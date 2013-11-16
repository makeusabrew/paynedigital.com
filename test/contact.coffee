boot   = require "./lib/boot"
helper = require "./lib/helper"
assert = require "./lib/assert"

describe "Contact page", ->
    browser = null

    before (done) ->
        browser = boot.getBrowser()
        boot.loadFixture done

    describe "When visiting the contact page", ->
        before (done) ->
            browser.visit "/contact", done

        describe "then filling out the contact form with valid data", ->
            before (done) ->
                browser
                .fill("#name", "Test User")
                .fill("#email", "test@example.com")
                .fill("#content", "This is a test contact form enquiry")
                .pressButton "Send", done

            it "should show the correct thank you message", ->
                assert.equal "Thanks! I appreciate you getting in touch and will get back to you shortly.", browser.text(".alert--success")
