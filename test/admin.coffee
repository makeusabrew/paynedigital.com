boot   = require "./lib/boot"
helper = require "./lib/helper"
Zombie = require "zombie"
assert = require "./lib/assert"

Zombie.site = boot.Settings.getValue "site", "base_href"

describe "Admin area", ->
    browser = null

    before (done) ->
        browser = new Zombie()
        boot.loadFixture done

    describe "When logging into the admin area as a valid user", ->
        before (done) ->
            browser
            .visit("/admin")
            .then ->
                helper.admin.login browser
            .then ->
                done()

        it "should show a greeting message", ->
            assert.equal "Hi Test.", browser.text("p:first")

        it "should show the correct posts for a user", ->
            assert.equal "This post will be published in the future", browser.text("tbody tr:eq(0) td:first")
            assert.equal "This Post Has Been Deleted", browser.text("tbody tr:eq(1) td:first")
            assert.equal "This Is A Test Post", browser.text("tbody tr:eq(2) td:first")
            assert.equal "A test post for comments", browser.text("tbody tr:eq(3) td:first")
            assert.equal "This post hasn't been published", browser.text("tbody tr:eq(4) td:first")

        it "should not show another user's posts", ->
            assert.equal 5, browser.queryAll("tbody tr").length

        describe "When editing an existing post", ->
            before (done) ->
                browser
                .clickLink("tbody tr:eq(0) a:first")
                .then ->
                    browser.fill "#title", "Test Post (Edited)"
                    browser.select "#status", "Draft"
                    browser.fill "#published", "01/09/21 12:34:56"
                .then ->
                    browser.pressButton "Save", done

            it "should update the submit button's content", ->
                assert.equal "Saved!", browser.query("input[type=submit]").value

            describe "When returning to the admin listing page", ->
                before (done) ->
                    browser.visit "/admin", done

                it "should show the updated post contents", ->
                    assert.equal "Test Post (Edited)", browser.text("tbody tr:eq(0) td:first")
                    assert.equal "DRAFT", browser.text("tbody tr:eq(0) td:eq(1)")
                    assert.equal "2021-09-01 12:34:56", browser.text("tbody tr:eq(0) td:eq(2)")
        
        describe "When creating a new post", ->
            before (done) ->
                browser
                .clickLink("New Post")
                .then ->
                    browser.fill "#title", "A New Post"
                    browser.fill "#url", "a-new-post"
                    browser.select "#status", "Published"
                    browser.fill "#published", "22/09/2011 11:54:51"
                    browser.fill "#introduction", "<p>Here is some test introductory content.</p>"
                    browser.fill "#content", "<p>Here is some test content.</p>"
                    browser.fill "#tags", "|test|tags|"
                .then ->
                    browser.pressButton "Save", done

            it "should update the submit button's content", ->
                assert.equal "Saved!", browser.query("input[type=submit]").value

            describe "When viewing the articles landing page", ->
                before (done) ->
                    browser.visit "/articles", done

                it "should show the newly created post", ->
                    assert.equal "A New Post", browser.text(".article__heading:first")

                it "should show the post intro copy", ->
                    assert.equal "Here is some test introductory content.", browser.text(".article-content:first p:first")

                describe "When following the link to the post", ->
                    before (done) ->
                        browser.clickLink "A New Post", done

                    it "should load the correct URL", ->
                        assert.equal "/2011/09/a-new-post", browser.location.pathname

                    it "should show the correct title", ->
                        assert.equal "A New Post", browser.text("h1")

                    it "should show the body copy", ->
                        assert.equal "Here is some test content.", browser.text(".article-content:first p:first")

        describe "When approving a pending comment", ->
            before (done) ->
                browser
                .clickLink("This Is A Test Post")
                .then ->
                    browser.select "#approved", "Yes"
                .then ->
                    browser.pressButton "Save", done

                describe "Then when viewing the post on the site", ->
                    before (done) ->
                        browser.visit "/2011/09/this-is-a-test-post", done

                    it "should show the correct number of comments", ->
                        assert.equal "1 comment", browser.text(".published a:eq(1)")

                    it "should show the comment on the page", ->
                        assert.equal "Mr Test", browser.text(".comment .commenter")
                        assert.equal "This is a comment", browser.text(".comment .copy")
