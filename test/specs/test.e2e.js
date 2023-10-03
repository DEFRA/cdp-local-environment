import { expect, browser, $ } from '@wdio/globals'

describe('My Login application', () => {
    it('should display welcome', async() => {

        await browser.url('http://localhost:3000/cdp-portal-frontend')

        const welcome = $('h1[data-testid="app-heading-title"]')
        await expect(welcome).toHaveText('Welcome')
    })

    it('should display templates', async () => {
        await browser.url('http://localhost:3000/cdp-portal-frontend/utilities/templates')

        const backendTemplate = await $('a=cdp-node-backend-template')
        await expect(backendTemplate).toHaveText('cdp-node-backend-template')

        const fontendTemplate = await $('a=cdp-node-frontend-template')
        await expect(fontendTemplate).toHaveText('cdp-node-frontend-template')

    })
})

