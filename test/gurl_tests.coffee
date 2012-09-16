assert = require("assert")
exec = require("child_process").exec
gurl = require("../lib/gurl")
describe "Gurl", ->
  it "should determine whether urls are self referencial", (done) ->
    gurl.isSelfRefURL "http://www.google.com", (well) ->
      assert.equal well, false
      gurl.isSelfRefURL "http://wlaurance.com/articles/7/11/gurl+url+checker", (well) ->
        assert.equal well, true
        done()

  it "should replace non self referencial urls with target=\"_blank\"", (done) ->
    testArticle = require(__dirname + "/test_article.coffee")
    gurl.processArticle testArticle, ->
      processed = gurl.articles[0].body
      processed.replace /(<a href="([^"]+)">([^<]+)<\/a>)/g, (href) ->
        unless href.indexOf("wlaurance.com") is -1
          assert.equal href.indexOf("target=\"_blank\""), -1
        else
          assert.notEqual href.indexOf("target=\"_blank\""), -1
        done()




