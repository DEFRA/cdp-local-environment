import subprocess
import os
import typer
import yaml

app = typer.Typer()

DEFAULT_ORGANIZATION = (
    "defra-cdp-sandpit"  # Change this to your default GitHub organization
)


def check_for_dockerfile(repo_path):
    """Check if the repository contains a Dockerfile."""
    return os.path.exists(os.path.join(repo_path, "Dockerfile"))


def checkout_latest_tag(repo_path):
    """Checkout the latest git tag in the given repo."""
    os.chdir(repo_path)
    subprocess.run(["git", "fetch", "--tags"])
    latest_tag = subprocess.getoutput(
        "git describe --tags `git rev-list --tags --max-count=1`"
    )
    subprocess.run(["git", "checkout", latest_tag])
    os.chdir("..")
    return latest_tag


def add_submodule(repo_url, submodule_path, token):
    """Add a git submodule for the given repo URL."""
    if not os.path.exists(submodule_path):
        # Construct URL with token
        authenticated_url = repo_url.replace(
            "https://", f"https://x-access-token:{token}@"
        )
        subprocess.run(["git", "submodule", "add", authenticated_url, submodule_path])


@app.command()
def initialize(token: str, org: str = DEFAULT_ORGANIZATION):
    """Initialize by adding repositories and creating docker-compose.yaml."""
    typer.echo(f"Fetching repositories from organization: {org}")

    # Here, you might want to integrate GitHub API to fetch repos from an organization.
    # For the sake of simplicity, we'll just ask user to enter repo names for now.
    repos = typer.prompt(
        f"Enter repository names (comma separated) from {org}", type=str
    )
    repo_list = [
        f"https://github.com/{org}/{repo.strip()}.git" for repo in repos.split(",")
    ]

    repo_tags = {}

    # Add each repository as a submodule and store the latest tag
    for repo_url in repo_list:
        repo_name = repo_url.split("/")[-1].replace(".git", "")
        add_submodule(repo_url, repo_name, token)

    subprocess.run(["git", "submodule", "update", "--init", "--recursive"])

    for repo_url in repo_list:
        repo_name = repo_url.split("/")[-1].replace(".git", "")
        latest_tag = checkout_latest_tag(repo_name)
        repo_tags[repo_name] = latest_tag

    # Check for Dockerfiles, build images, and prepare docker-compose entries
    docker_compose_services = {}
    for repo_name, latest_tag in repo_tags.items():
        if check_for_dockerfile(repo_name):
            # Build docker image
            image_name = f"{repo_name}:{latest_tag}"
            subprocess.run(
                [
                    "docker",
                    "build",
                    "--no-cache",
                    "-t",
                    image_name,
                    repo_name,
                ]
            )

            # Add entry to docker-compose services
            docker_compose_services[repo_name] = {
                "image": image_name,
                "container_name": repo_name,
            }

    # Create docker-compose.yaml
    docker_compose_content = {"version": "3", "services": docker_compose_services}

    with open("docker-compose.yaml", "w") as f:
        yaml.dump(docker_compose_content, f, default_flow_style=False)

    typer.echo("Processed repositories and created docker-compose.yaml")


@app.command()
def update():
    """Update submodules to latest tags and docker-compose.yaml."""
    # Update each submodule to the latest tag
    subprocess.run(["git", "submodule", "foreach", "git", "fetch", "--tags"])
    subprocess.run(
        [
            "git",
            "submodule",
            "foreach",
            "git checkout $(git describe --tags `git rev-list --tags --max-count=1`)",
        ]
    )

    # Detect repository names from submodules
    repo_names = (
        subprocess.getoutput(
            "git config --file .gitmodules --get-regexp path | awk '{ print $2 }'"
        )
        .strip()
        .split()
    )

    print("repo-names is " + repo_names.__str__())

    # Check for Dockerfiles, build images, and prepare docker-compose entries
    docker_compose_services = {}
    for repo_name in repo_names:
        latest_tag = checkout_latest_tag(repo_name)
        if check_for_dockerfile(repo_name):
            # Build docker image
            image_name = f"{repo_name}:{latest_tag}"
            subprocess.run(["docker", "build", "-t", image_name, repo_name])

            # Add entry to docker-compose services
            docker_compose_services[repo_name] = {
                "image": image_name,
                "container_name": repo_name,
            }

    # Update docker-compose.yaml
    docker_compose_content = {"version": "3", "services": docker_compose_services}

    with open("docker-compose.yaml.update", "w") as f:
        yaml.dump(docker_compose_content, f, default_flow_style=False)

    typer.echo("Updated repositories and docker-compose.yaml")


if __name__ == "__main__":
    app()
