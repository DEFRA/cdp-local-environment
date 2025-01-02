#!/bin/bash
echo Setting up Portal Queues

source /etc/localstack/conf.d/local-defaults.env

# examples

# basic requests
# aws sns --endpoint http://localhost:4566 list-topics
# aws --endpoint http://localhost:4566 sqs create-queue --queue-name my-queue
# aws --endpoint http://localhost:4566 sns create-topic --name my-topic
# aws --endpoint http://localhost:4566 sns subscribe --topic-arn arn:aws:sns:eu-west-2:000000000000:my-topic --protocol sqs --notification-endpoint  arn:aws:sqs:eu-west-2:000000000000:my-queue
# aws --endpoint http://localhost:4566 sns list-subscriptions

# publish github-event
# aws sqs --endpoint http://localhost:4566 --region $AWS_REGION send-message --queue-url http://sqs.eu-west-2.127.0.0.1:4566/000000000000/github-events --message-body '{"action":"completed","workflow_run":{"id":11050812809,"name":"Update Deployments to S3","node_id":"WFR_kwLOMU-m7c8AAAACkq4FiQ","head_branch":"main","head_sha":"0a53761170eacc7ec36cd964553b91e478ecb73c","path":".github/workflows/update-deployments.yaml","display_title":"Merge pull request #6 from DEFRA/chotai-patch-1","run_number":972,"event":"push","status":"completed","conclusion":"failure","workflow_id":109383550,"check_suite_id":28877208132,"check_suite_node_id":"CS_kwDOMU-m7c8AAAAGuTc6RA","url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/actions/runs/11050812809","html_url":"https://github.com/DEFRA/cdp-app-deployments/actions/runs/11050812809","pull_requests":[],"created_at":"2024-09-26T10:55:57Z","updated_at":"2024-09-26T10:56:15Z","actor":{"login":"chotai","id":8394045,"node_id":"MDQ6VXNlcjgzOTQwNDU=","avatar_url":"https://avatars.githubusercontent.com/u/8394045?v=4","gravatar_id":"","url":"https://api.github.com/users/chotai","html_url":"https://github.com/chotai","followers_url":"https://api.github.com/users/chotai/followers","following_url":"https://api.github.com/users/chotai/following{/other_user}","gists_url":"https://api.github.com/users/chotai/gists{/gist_id}","starred_url":"https://api.github.com/users/chotai/starred{/owner}{/repo}","subscriptions_url":"https://api.github.com/users/chotai/subscriptions","organizations_url":"https://api.github.com/users/chotai/orgs","repos_url":"https://api.github.com/users/chotai/repos","events_url":"https://api.github.com/users/chotai/events{/privacy}","received_events_url":"https://api.github.com/users/chotai/received_events","type":"User","site_admin":false},"run_attempt":1,"referenced_workflows":[],"run_started_at":"2024-09-26T10:55:57Z","triggering_actor":{"login":"chotai","id":8394045,"node_id":"MDQ6VXNlcjgzOTQwNDU=","avatar_url":"https://avatars.githubusercontent.com/u/8394045?v=4","gravatar_id":"","url":"https://api.github.com/users/chotai","html_url":"https://github.com/chotai","followers_url":"https://api.github.com/users/chotai/followers","following_url":"https://api.github.com/users/chotai/following{/other_user}","gists_url":"https://api.github.com/users/chotai/gists{/gist_id}","starred_url":"https://api.github.com/users/chotai/starred{/owner}{/repo}","subscriptions_url":"https://api.github.com/users/chotai/subscriptions","organizations_url":"https://api.github.com/users/chotai/orgs","repos_url":"https://api.github.com/users/chotai/repos","events_url":"https://api.github.com/users/chotai/events{/privacy}","received_events_url":"https://api.github.com/users/chotai/received_events","type":"User","site_admin":false},"jobs_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/actions/runs/11050812809/jobs","logs_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/actions/runs/11050812809/logs","check_suite_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/check-suites/28877208132","artifacts_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/actions/runs/11050812809/artifacts","cancel_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/actions/runs/11050812809/cancel","rerun_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/actions/runs/11050812809/rerun","previous_attempt_url":null,"workflow_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/actions/workflows/109383550","head_commit":{"id":"0a53761170eacc7ec36cd964553b91e478ecb73c","tree_id":"088594720efd8f5aa0ba5fed27025e1bc0dbd073","message":"Merge pull request #6 from DEFRA/chotai-patch-1\n\nUpdate README.md","timestamp":"2024-09-26T10:55:54Z","author":{"name":"Sunny Chotai","email":"chotai@users.noreply.github.com"},"committer":{"name":"GitHub","email":"noreply@github.com"}},"repository":{"id":827303661,"node_id":"R_kgDOMU-m7Q","name":"cdp-app-deployments","full_name":"DEFRA/cdp-app-deployments","private":true,"owner":{"login":"DEFRA","id":5528822,"node_id":"MDEyOk9yZ2FuaXphdGlvbjU1Mjg4MjI=","avatar_url":"https://avatars.githubusercontent.com/u/5528822?v=4","gravatar_id":"","url":"https://api.github.com/users/DEFRA","html_url":"https://github.com/DEFRA","followers_url":"https://api.github.com/users/DEFRA/followers","following_url":"https://api.github.com/users/DEFRA/following{/other_user}","gists_url":"https://api.github.com/users/DEFRA/gists{/gist_id}","starred_url":"https://api.github.com/users/DEFRA/starred{/owner}{/repo}","subscriptions_url":"https://api.github.com/users/DEFRA/subscriptions","organizations_url":"https://api.github.com/users/DEFRA/orgs","repos_url":"https://api.github.com/users/DEFRA/repos","events_url":"https://api.github.com/users/DEFRA/events{/privacy}","received_events_url":"https://api.github.com/users/DEFRA/received_events","type":"Organization","site_admin":false},"html_url":"https://github.com/DEFRA/cdp-app-deployments","description":"Git repository for cdp-app-deployments","fork":false,"url":"https://api.github.com/repos/DEFRA/cdp-app-deployments","forks_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/forks","keys_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/keys{/key_id}","collaborators_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/collaborators{/collaborator}","teams_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/teams","hooks_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/hooks","issue_events_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/issues/events{/number}","events_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/events","assignees_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/assignees{/user}","branches_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/branches{/branch}","tags_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/tags","blobs_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/git/blobs{/sha}","git_tags_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/git/tags{/sha}","git_refs_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/git/refs{/sha}","trees_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/git/trees{/sha}","statuses_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/statuses/{sha}","languages_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/languages","stargazers_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/stargazers","contributors_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/contributors","subscribers_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/subscribers","subscription_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/subscription","commits_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/commits{/sha}","git_commits_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/git/commits{/sha}","comments_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/comments{/number}","issue_comment_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/issues/comments{/number}","contents_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/contents/{+path}","compare_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/compare/{base}...{head}","merges_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/merges","archive_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/{archive_format}{/ref}","downloads_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/downloads","issues_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/issues{/number}","pulls_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/pulls{/number}","milestones_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/milestones{/number}","notifications_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/notifications{?since,all,participating}","labels_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/labels{/name}","releases_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/releases{/id}","deployments_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/deployments"},"head_repository":{"id":827303661,"node_id":"R_kgDOMU-m7Q","name":"cdp-app-deployments","full_name":"DEFRA/cdp-app-deployments","private":true,"owner":{"login":"DEFRA","id":5528822,"node_id":"MDEyOk9yZ2FuaXphdGlvbjU1Mjg4MjI=","avatar_url":"https://avatars.githubusercontent.com/u/5528822?v=4","gravatar_id":"","url":"https://api.github.com/users/DEFRA","html_url":"https://github.com/DEFRA","followers_url":"https://api.github.com/users/DEFRA/followers","following_url":"https://api.github.com/users/DEFRA/following{/other_user}","gists_url":"https://api.github.com/users/DEFRA/gists{/gist_id}","starred_url":"https://api.github.com/users/DEFRA/starred{/owner}{/repo}","subscriptions_url":"https://api.github.com/users/DEFRA/subscriptions","organizations_url":"https://api.github.com/users/DEFRA/orgs","repos_url":"https://api.github.com/users/DEFRA/repos","events_url":"https://api.github.com/users/DEFRA/events{/privacy}","received_events_url":"https://api.github.com/users/DEFRA/received_events","type":"Organization","site_admin":false},"html_url":"https://github.com/DEFRA/cdp-app-deployments","description":"Git repository for cdp-app-deployments","fork":false,"url":"https://api.github.com/repos/DEFRA/cdp-app-deployments","forks_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/forks","keys_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/keys{/key_id}","collaborators_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/collaborators{/collaborator}","teams_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/teams","hooks_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/hooks","issue_events_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/issues/events{/number}","events_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/events","assignees_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/assignees{/user}","branches_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/branches{/branch}","tags_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/tags","blobs_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/git/blobs{/sha}","git_tags_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/git/tags{/sha}","git_refs_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/git/refs{/sha}","trees_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/git/trees{/sha}","statuses_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/statuses/{sha}","languages_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/languages","stargazers_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/stargazers","contributors_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/contributors","subscribers_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/subscribers","subscription_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/subscription","commits_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/commits{/sha}","git_commits_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/git/commits{/sha}","comments_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/comments{/number}","issue_comment_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/issues/comments{/number}","contents_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/contents/{+path}","compare_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/compare/{base}...{head}","merges_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/merges","archive_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/{archive_format}{/ref}","downloads_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/downloads","issues_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/issues{/number}","pulls_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/pulls{/number}","milestones_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/milestones{/number}","notifications_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/notifications{?since,all,participating}","labels_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/labels{/name}","releases_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/releases{/id}","deployments_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/deployments"}},"workflow":{"id":109383550,"node_id":"W_kwDOMU-m7c4GhQ9-","name":"Update Deployments to S3","path":".github/workflows/update-deployments.yaml","state":"active","created_at":"2024-07-26T15:39:20.000Z","updated_at":"2024-07-26T15:39:20.000Z","url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/actions/workflows/109383550","html_url":"https://github.com/DEFRA/cdp-app-deployments/blob/main/.github/workflows/update-deployments.yaml","badge_url":"https://github.com/DEFRA/cdp-app-deployments/workflows/Update%20Deployments%20to%20S3/badge.svg"},"repository":{"id":827303661,"node_id":"R_kgDOMU-m7Q","name":"cdp-app-deployments","full_name":"DEFRA/cdp-app-deployments","private":true,"owner":{"login":"DEFRA","id":5528822,"node_id":"MDEyOk9yZ2FuaXphdGlvbjU1Mjg4MjI=","avatar_url":"https://avatars.githubusercontent.com/u/5528822?v=4","gravatar_id":"","url":"https://api.github.com/users/DEFRA","html_url":"https://github.com/DEFRA","followers_url":"https://api.github.com/users/DEFRA/followers","following_url":"https://api.github.com/users/DEFRA/following{/other_user}","gists_url":"https://api.github.com/users/DEFRA/gists{/gist_id}","starred_url":"https://api.github.com/users/DEFRA/starred{/owner}{/repo}","subscriptions_url":"https://api.github.com/users/DEFRA/subscriptions","organizations_url":"https://api.github.com/users/DEFRA/orgs","repos_url":"https://api.github.com/users/DEFRA/repos","events_url":"https://api.github.com/users/DEFRA/events{/privacy}","received_events_url":"https://api.github.com/users/DEFRA/received_events","type":"Organization","site_admin":false},"html_url":"https://github.com/DEFRA/cdp-app-deployments","description":"Git repository for cdp-app-deployments","fork":false,"url":"https://api.github.com/repos/DEFRA/cdp-app-deployments","forks_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/forks","keys_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/keys{/key_id}","collaborators_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/collaborators{/collaborator}","teams_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/teams","hooks_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/hooks","issue_events_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/issues/events{/number}","events_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/events","assignees_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/assignees{/user}","branches_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/branches{/branch}","tags_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/tags","blobs_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/git/blobs{/sha}","git_tags_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/git/tags{/sha}","git_refs_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/git/refs{/sha}","trees_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/git/trees{/sha}","statuses_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/statuses/{sha}","languages_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/languages","stargazers_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/stargazers","contributors_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/contributors","subscribers_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/subscribers","subscription_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/subscription","commits_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/commits{/sha}","git_commits_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/git/commits{/sha}","comments_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/comments{/number}","issue_comment_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/issues/comments{/number}","contents_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/contents/{+path}","compare_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/compare/{base}...{head}","merges_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/merges","archive_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/{archive_format}{/ref}","downloads_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/downloads","issues_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/issues{/number}","pulls_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/pulls{/number}","milestones_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/milestones{/number}","notifications_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/notifications{?since,all,participating}","labels_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/labels{/name}","releases_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/releases{/id}","deployments_url":"https://api.github.com/repos/DEFRA/cdp-app-deployments/deployments","created_at":"2024-07-11T11:43:39Z","updated_at":"2024-09-26T10:55:58Z","pushed_at":"2024-09-26T10:55:55Z","git_url":"git://github.com/DEFRA/cdp-app-deployments.git","ssh_url":"git@github.com:DEFRA/cdp-app-deployments.git","clone_url":"https://github.com/DEFRA/cdp-app-deployments.git","svn_url":"https://github.com/DEFRA/cdp-app-deployments","homepage":null,"size":1213,"stargazers_count":0,"watchers_count":0,"language":"Python","has_issues":true,"has_projects":true,"has_downloads":true,"has_wiki":true,"has_pages":false,"has_discussions":false,"forks_count":0,"mirror_url":null,"archived":false,"disabled":false,"open_issues_count":0,"license":null,"allow_forking":true,"is_template":false,"web_commit_signoff_required":false,"topics":["cdp","repository"],"visibility":"internal","forks":0,"open_issues":0,"watchers":0,"default_branch":"main","custom_properties":{}},"organization":{"login":"DEFRA","id":5528822,"node_id":"MDEyOk9yZ2FuaXphdGlvbjU1Mjg4MjI=","url":"https://api.github.com/orgs/DEFRA","repos_url":"https://api.github.com/orgs/DEFRA/repos","events_url":"https://api.github.com/orgs/DEFRA/events","hooks_url":"https://api.github.com/orgs/DEFRA/hooks","issues_url":"https://api.github.com/orgs/DEFRA/issues","members_url":"https://api.github.com/orgs/DEFRA/members{/member}","public_members_url":"https://api.github.com/orgs/DEFRA/public_members{/member}","avatar_url":"https://avatars.githubusercontent.com/u/5528822?v=4","description":"UK government department responsible for safeguarding our natural environment, supporting our food & farming industry, and sustaining a thriving rural economy."},"enterprise":{"id":3627,"slug":"defra","name":"Department for Environment, Food and Rural Affairs","node_id":"MDEwOkVudGVycHJpc2UzNjI3","avatar_url":"https://avatars.githubusercontent.com/b/3627?v=4","description":null,"website_url":null,"html_url":"https://github.com/enterprises/defra","created_at":"2020-07-10T22:09:01Z","updated_at":"2024-07-25T16:30:34Z"},"sender":{"login":"chotai","id":8394045,"node_id":"MDQ6VXNlcjgzOTQwNDU=","avatar_url":"https://avatars.githubusercontent.com/u/8394045?v=4","gravatar_id":"","url":"https://api.github.com/users/chotai","html_url":"https://github.com/chotai","followers_url":"https://api.github.com/users/chotai/followers","following_url":"https://api.github.com/users/chotai/following{/other_user}","gists_url":"https://api.github.com/users/chotai/gists{/gist_id}","starred_url":"https://api.github.com/users/chotai/starred{/owner}{/repo}","subscriptions_url":"https://api.github.com/users/chotai/subscriptions","organizations_url":"https://api.github.com/users/chotai/orgs","repos_url":"https://api.github.com/users/chotai/repos","events_url":"https://api.github.com/users/chotai/events{/privacy}","received_events_url":"https://api.github.com/users/chotai/received_events","type":"User","site_admin":false},"github_event":"workflow_run"}'

# publish grafana alert
# aws sqs --endpoint http://localhost:4566 --region $AWS_REGION send-message --queue-url http://sqs.eu-west-2.127.0.0.1:4566/000000000000/cdp-notify --message-body '{"environment":"prod","service":"test-service","team":"Platform","alertName":"test-service - prod","status":"firing","startsAt":"2024-11-04 12:53:20 +0000 UTC","endsAt":"2024-11-04 12:53:20 +0000 UTC","summary":"A test suite","description":"","series":"","runbookUrl":"","alertURL":"https://grafana/alerting/grafana/0000/view"}'

# publish vanity urls
# aws sqs --endpoint http://localhost:4566  send-message --queue-url http://sqs.eu-west-2.127.0.0.1:4566/000000000000/cdp_workflow_events --message-body '{"eventType":"nginx-vanity-urls","timestamp":"2024-10-23T15:10:10.123","payload":{"environment":"infra-dev","services":[{"name":"service-a","urls":[{"domain":"service.gov.uk","host":"service-a"},{"domain":"service.gov.uk","host":"service-b"},{"domain":"service.gov.uk","host":"service-b"}]},{"name":"service-b","urls":[{"domain":"service.gov.uk","host":"service-b"},{"domain":"service.gov.uk","host":"service-d"}]}]}}'
# aws sqs --endpoint http://localhost:4566  send-message --queue-url http://sqs.eu-west-2.127.0.0.1:4566/000000000000/cdp_workflow_events --message-body '{"eventType":"nginx-vanity-urls","timestamp":"2024-10-23T15:10:10.123","payload":{"environment":"prod","services":[]}}'
# aws sns --endpoint http://localhost:4566 publish --topic-arn arn:aws:sns:eu-west-2:000000000000:cdp_workflow_events --message '{"eventType":"nginx-vanity-urls","timestamp":"2024-12-19T00:28:10.828759+00:00","payload":{"environment":"prod","services":[{"name":"eutd-mmo-bc","urls":[{"domain":"service.gov.uk","host":"check-fish-exports-certificate"}]},{"name":"phi-frontend","urls":[{"domain":"service.gov.uk","host":"check-plant-health-information"}]},{"name":"cdp-example-node-frontend","urls":[{"domain":"defra.gov.uk","host":"cdp-service"}]},{"name":"disinfectant-frontend","urls":[{"domain":"defra.gov.uk","host":"disinfectants"}]},{"name":"aqie-front-end","urls":[{"domain":"defra.gov.uk","host":"check-local-air-quality"},{"domain":"service.gov.uk","host":"check-air-quality"}]},{"name":"forms-runner","urls":[{"domain":"service.gov.uk","host":"submit-form-to-defra"}]}]}}'
