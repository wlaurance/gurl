class Gurl
  constructor:()->
    @nonSelfRefURLS = true

  load:(glog)->
    glog.registerPostArticleHook (articles, cb)=>
      @processArticles articles, (processedArticles)->
        cb null, processedArticles

  processArticles:(articles, cb)->


  isSelfRefURL:(url, cb)->

module.exports = new Gurl
