// Generated by CoffeeScript 1.9.3
(function() {
  var Task;

  Task = (function() {
    function Task() {}

    Task.prototype.name = 'test';

    return Task;

  })();

  describe('TODO', function() {
    it('should not fail', function() {});
    return it('should have name', function() {
      var task;
      task = new Task;
      return task.name.should.equal("test");
    });
  });

}).call(this);
