fs = require 'fs'
urlparse = require 'urlparse'
class Gurl
  constructor:()->
    @nonSelfRefURLS = true
    @anchorList = []

  load:(glog)->
    glog.registerPostArticleHook (articles, cb)=>
      @processArticles articles, (processedArticles)->
        cb null, processedArticles

  processArticles:(articles, cb)->

  processArticle:(article, cb)->
    @appendAnchorList article, =>
      cb(@anchorList)

  appendAnchorList:(article, cb)->
    article.replace /(<a href="([^"]+)">([^<]+)<\/a>)/g, (href)=>
      @anchorList.push href
    cb()

  isSelfRefURL:(url, cb)->
    fs.readFile __dirname + '/../config.json', (error, data)->
      throw error if error?
      try
        domain = JSON.parse(data).domain
        if domain is urlparse(url).host
          cb true
        else
          cb false
      catch e
        throw e
    

module.exports = new Gurl
