// Generated by CoffeeScript 1.7.1
(function() {
  this.Maslosoft.Ko.Balin.register = function(name, handler) {
    ko.bindingHandlers[name] = handler;
    if (handler.writable) {
      return ko.expressionRewriting.twoWayBindings[name] = true;
    }
  };

  this.Maslosoft.Ko.Balin.registerDefaults = function() {
    return Maslosoft.Ko.Balin.register('htmlValue', new Maslosoft.Ko.Balin.HtmlValue);
  };

}).call(this);
