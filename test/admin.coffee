boot   = require "./lib/boot"
helper = require "./lib/helper"
Zombie = require "zombie"
assert = require "assert"

Zombie.site = boot.Settings.getValue "site", "base_href"

describe "Admin area", ->
    browser = null

    before (done) ->
        browser = new Zombie()
        boot.loadFixture done

    describe "When logging into the admin area", ->
        before (done) ->
            browser
            .visit("/admin")
            .then ->
                helper.admin.login browser
            .then ->
                done()

        it "should show a greeting message", ->
            assert.equal "Hi Test.", browser.text("p:first")
                
