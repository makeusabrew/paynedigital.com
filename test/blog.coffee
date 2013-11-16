boot   = require "./lib/boot"
helper = require "./lib/helper"
assert = require "./lib/assert"

describe "Blog tests", ->
    browser = null

    before (done) ->
        browser = boot.getBrowser()
        boot.loadFixture done

    describe "When visiting the articles listing page", ->
        before (done) ->
            browser.visit "/articles", done

        it "should show the three most recent posts in the correct order", ->
            assert.equal "Another Test Post", browser.text(".article:nth-of-type(1) h2")
            assert.equal "This Is A Test Post", browser.text(".article:nth-of-type(2) h2")
            assert.equal "Testing Tags", browser.text(".article:nth-of-type(3) h2")

        it "should only show three recent posts", ->
            assert.equal 3, browser.queryAll(".article").length

        it "should link to the posts correctly", ->
            href = browser.query(".article a:nth-of-type(1)").href
            assert.equal "#{browser.site}articles/2011/09/another-test-post", href

        describe "When visiting an article page", ->
            before (done) ->
                browser.visit "/2011/09/another-test-post", done

            it "should show the correct title", ->
                assert.equal "Another Test Post | Payne Digital Ltd", browser.text("title")

            it "should show approved comments in the correct order", ->
                assert.equal "15th September 2011 at 09:33", browser.text("#comments .comments__comment:nth-of-type(1) time")
                assert.equal "16th September 2011 at 12:56", browser.text("#comments .comments__comment:nth-of-type(2) time")
