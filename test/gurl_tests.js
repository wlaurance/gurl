var assert = require('assert'),
    exec = require('child_process').exec;
var gurl = require('../lib/gurl');
describe('Gurl', function() {
  it('should determine whether urls are self referencial', function(done){
    gurl.isSelfRefURL('http://www.google.com', function(well){
      assert.equal(well, false);
      gurl.isSelfRefURL('http://wlaurance.com/articles/7/11/gurl+url+checker', function(well){
        assert.equal(well, true);
        done();
      });
    });
  });
  it('should replace non self referencial urls with target="_blank"', function(done){
    var testArticle = require('./test_article');
    gurl.processArticle(testArticle, function(processed){
      processed.replace(/(<a href="([^"]+)">([^<]+)<\/a>)/g, function(href){
        if(href.indexOf('wlaurance.com') != -1)
          assert.equal(href.indexOf('target="_blank"'), -1);
        else
          assert.notEqual(href.indexOf('target="_blank"'), -1);
      });
    });
  });
});
