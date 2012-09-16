try
  fs = require 'fs'
  urlparse = require 'urlparse'
  async = require 'async'
catch e
  console.error e
class Gurl
  constructor:()->
    @nonSelfRefURLS = true
    @articles = []

  load:(glog)->
    glog.registerPostArticleHook (articles, cb)=>
      @articles = []
      async.forEach articles, @processArticle, (error)=>
        cb null, @articles

  processArticle:(article, cb)=>
    @appendAnchorList article.body, (anchors)=>
      iterator = (href, icb)=>
        href = '' if href is undefined
        href.replace /(http(s)?:d)?(([^:\s]+)\.(\w)+)/g, (url)=>
          @isSelfRefURL url, (well)=>
            if well is false
              newhref = String href
              newhref = newhref.replace '<a', '<a target="_blank"'
              article.body = article.body.replace href, newhref
            icb()
      if anchors.length isnt 0
        async.forEachSeries anchors, iterator, (error)=>
          @articles.push article
          cb(error)
      else
        @articles.push article
        cb('')

  appendAnchorList:(body, cb)->
    anchors = []
    body.replace /(<a href="([^"]+)">([^<]+)<\/a>)/g, (href)=>
      anchors.push href
    cb(anchors)

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
        console.log e
        throw e

module.exports = new Gurl
