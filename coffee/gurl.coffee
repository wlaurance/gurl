fs = require 'fs'
urlparse = require 'urlparse'
class Gurl
  constructor:()->
    @nonSelfRefURLS = true

  load:(glog)->
    glog.registerPostArticleHook (articles, cb)=>
      @processArticles articles, (processedArticles)->
        cb null, processedArticles

  processArticles:(articles, cb)->


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
