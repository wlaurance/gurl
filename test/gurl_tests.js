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
});
