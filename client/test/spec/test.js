(function() {
  'use strict';

  var $;

  $ = jQuery();

  describe('The WebApp', function() {
    return it('should have a namespaced \'app\' object', function(done) {
      return $(function() {
        (expect(app)).to.be.an('object');
        return (expect(1 + 1)).to.equal(3);
      });
    });
  });

}).call(this);
