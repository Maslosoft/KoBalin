// Generated by CoffeeScript 1.7.1
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.Maslosoft.Ko.Balin.Base = (function() {
    Base.prototype.options = null;

    function Base(options) {
      this.options = options != null ? options : {};
      this.getValue = __bind(this.getValue, this);
    }

    Base.prototype.getValue = function(valueAccessor) {
      var value;
      value = ko.unwrap(valueAccessor());
      if (this.options.valueField) {
        if (this.options.ec5) {
          value = value[this.options.valueField];
        } else {
          value = value[this.options.valueField]();
        }
      }
      return value;
    };

    Base.prototype.setValue = function(valueAccessor, value) {};

    return Base;

  })();

}).call(this);
