var assert = require('assert'),
    exec = require('child_process').exec;
var gurl = require('../lib/gurl');
describe('Gurl', function() {
  it('should determine whether urls are self referencial', function(done){
    gurl.isURLSelfReferencial('http://www.google.com', function(well){
      assert.equal(well, false);
      done();
    });
  });
});


