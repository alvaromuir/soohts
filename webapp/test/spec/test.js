(function() {
  'use strict';

  describe('Give it some context', function() {
    return describe('maybe a bit more context here', function() {
      return it('should run here few assertions', function() {
        return (expect(1 + 1)).to.equal(2);
      });
    });
  });

}).call(this);
