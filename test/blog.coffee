assert = require "./lib/assert"
boot   = require "./lib/boot"
helper = require "./lib/helper"
Zombie = require "zombie"

Zombie.site = boot.Settings.getValue "site", "base_href"

describe "Blog tests", ->
    browser = null

    before (done) ->
        browser = new Zombie()
        boot.loadFixture done

    describe "When visiting the home page", ->
        before (done) ->
            browser.visit "/", done

        it "should show the three most recent posts in the correct order", ->
            assert.equal "Another Test Post", browser.text(".post:eq(0) h2")
            assert.equal "This Is A Test Post", browser.text(".post:eq(1) h2")
            assert.equal "Testing Tags", browser.text(".post:eq(2) h2")

        it "should only show three recent posts", ->
            assert.equal 3, browser.queryAll("#posts .post").length

        it "should link to the posts correctly", ->
            href = browser.query("#posts .post a:first")._attributes.href._nodeValue
            assert.equal "/2011/09/another-test-post", href

        describe "When visiting an article page", ->
            before (done) ->
                browser.visit "/2011/09/another-test-post", done

            it "should show the correct title", ->
                assert.equal "Payne Digital Ltd—Another Test Post", browser.text("title")

            it "should show approved comments in the correct order", ->
                assert.equal "15th September 2011 at 09:33", browser.text("#comments .comment:eq(0) time")
                assert.equal "16th September 2011 at 12:56", browser.text("#comments .comment:eq(1) time")
