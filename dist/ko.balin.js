(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  if (!this.Maslosoft) {
    this.Maslosoft = {};
  }

  if (!this.Maslosoft.Ko) {
    this.Maslosoft.Ko = {};
  }

  if (!this.Maslosoft.Ko.Balin) {
    this.Maslosoft.Ko.Balin = {};
  }

  this.Maslosoft.Ko.Balin.register = function(name, handler) {
    ko.bindingHandlers[name] = handler;
    if (handler.writable) {
      return ko.expressionRewriting.twoWayBindings[name] = true;
    }
  };

  this.Maslosoft.Ko.Balin.registerDefaults = function() {
    Maslosoft.Ko.Balin.register('htmlValue', new Maslosoft.Ko.Balin.HtmlValue);
    return Maslosoft.Ko.Balin.register('fileSizeFormatter', new Maslosoft.Ko.Balin.FileSizeFormatter);
  };

  this.Maslosoft.Ko.Balin.Base = (function() {
    Base.prototype.writable = true;

    Base.prototype.options = null;

    function Base(options) {
      this.options = options != null ? options : {};
      this.getValue = __bind(this.getValue, this);
    }

    Base.prototype.getValue = function(valueAccessor, defaults) {
      var value;
      if (defaults == null) {
        defaults = '';
      }
      value = ko.unwrap(valueAccessor());
      if (this.options.valueField) {
        if (this.options.ec5) {
          value = value[this.options.valueField];
        } else {
          value = value[this.options.valueField]();
        }
      }
      return value || defaults;
    };

    Base.prototype.setValue = function(valueAccessor, value) {};

    return Base;

  })();

  this.Maslosoft.Ko.Balin.Options = (function() {
    Options.prototype.valueField = null;

    Options.prototype.ec5 = null;

    function Options(values) {
      var index, value;
      if (values == null) {
        values = {};
      }
      for (index in values) {
        value = values[index];
        this[index] = value;
      }
      if (this.ec5 === null) {
        this.ec5 = !!ko.track;
      }
    }

    return Options;

  })();

  this.Maslosoft.Ko.Balin.DateTime = (function(_super) {
    __extends(DateTime, _super);

    function DateTime(options) {
      this.options = new this.Maslosoft.Ko.Balin.DateTimeOptions(options);
    }

    return DateTime;

  })(this.Maslosoft.Ko.Balin.Base);

  this.Maslosoft.Ko.Balin.DateTimeOptions = (function(_super) {
    __extends(DateTimeOptions, _super);

    function DateTimeOptions() {
      return DateTimeOptions.__super__.constructor.apply(this, arguments);
    }

    DateTimeOptions.prototype.displayFormat = 'YYYY-MM-DD';

    return DateTimeOptions;

  })(this.Maslosoft.Ko.Balin.Options);

  this.Maslosoft.Ko.Balin.FileSizeFormatter = (function(_super) {
    __extends(FileSizeFormatter, _super);

    function FileSizeFormatter() {
      return FileSizeFormatter.__super__.constructor.apply(this, arguments);
    }

    FileSizeFormatter.prototype.init = function(element, valueAccessor, allBindingsAccessor, viewModel) {};

    FileSizeFormatter.prototype.update = function(element, valueAccessor, allBindingsAccessor, viewModel) {
      var format, value;
      value = this.getValue(valueAccessor);
      format = function(bytes) {
        var i, units;
        i = -1;
        units = [" kB", " MB", " GB", " TB", "PB", "EB", "ZB", "YB"];
        while (true) {
          bytes = bytes / 1024;
          i++;
          if (!(bytes > 1024)) {
            break;
          }
        }
        return Math.max(bytes, 0.1).toFixed(1) + units[i];
      };
      element.innerHTML = format(value);
    };

    return FileSizeFormatter;

  })(this.Maslosoft.Ko.Balin.Base);

  this.Maslosoft.Ko.Balin.HtmlValue = (function(_super) {
    var idCounter;

    __extends(HtmlValue, _super);

    function HtmlValue() {
      this.update = __bind(this.update, this);
      this.init = __bind(this.init, this);
      return HtmlValue.__super__.constructor.apply(this, arguments);
    }

    idCounter = 0;

    HtmlValue.prototype.init = function(element, valueAccessor, allBindingsAccessor, context) {
      var handler;
      element.setAttribute('contenteditable', true);
      if (!element.id) {
        element.id = "Maslosoft-Ko-Balin-HtmlValue-" + (idCounter++);
      }
      handler = (function(_this) {
        return function(e) {
          var accessor, elementValue, modelValue;
          if (!element) {
            return;
          }
          element = document.getElementById(element.id);
          if (!element) {
            return;
          }
          accessor = valueAccessor();
          modelValue = _this.getValue(valueAccessor);
          elementValue = element.innerHTML;
          if (ko.isWriteableObservable(accessor)) {
            if (modelValue !== elementValue) {
              return accessor(elementValue);
            }
          }
        };
      })(this);
      ko.utils.registerEventHandler(element, "keyup, input", handler);
      $(document).on("mouseup", handler);
    };

    HtmlValue.prototype.update = function(element, valueAccessor) {
      var value;
      value = this.getValue(valueAccessor);
      if (element.innerHTML !== value) {
        element.innerHTML = value;
      }
    };

    return HtmlValue;

  })(this.Maslosoft.Ko.Balin.Base);


  /*
  One-way date/time formatter
   */

  this.Maslosoft.Ko.Balin.MomentFormatter = (function(_super) {
    __extends(MomentFormatter, _super);

    function MomentFormatter() {
      this.update = __bind(this.update, this);
      this.init = __bind(this.init, this);
      return MomentFormatter.__super__.constructor.apply(this, arguments);
    }

    MomentFormatter.prototype.init = function(element, valueAccessor, allBindingsAccessor, viewModel) {
      moment.lang(this.options.lang);
    };

    MomentFormatter.prototype.update = function(element, valueAccessor, allBindingsAccessor, viewModel) {
      var value;
      value = this.getValue(valueAccessor);
      element.innerHTML = moment[this.sourceformat](value).format(this.displayformat);
    };

    return MomentFormatter;

  })(this.Maslosoft.Ko.Balin.Base);

  this.Maslosoft.Ko.Balin.MomentOptions = (function(_super) {
    __extends(MomentOptions, _super);

    function MomentOptions() {
      return MomentOptions.__super__.constructor.apply(this, arguments);
    }

    MomentOptions.prototype.sourceFormat = 'unix';

    MomentOptions.prototype.displayFormat = null;

    return MomentOptions;

  })(this.Maslosoft.Ko.Balin.Options);

  this.Maslosoft.Ko.getType = function(type) {
    if (x && typeof x === 'object') {
      if (x.constructor === Date) {
        return 'date';
      }
      if (x.constructor === Array) {
        return 'array';
      }
    }
    return typeof x;
  };

  this.Maslosoft.Ko.objByName = function(name, context) {
    var args, func, i, n, ns, part, _i, _len;
    if (context == null) {
      context = window;
    }
    args = Array.prototype.slice.call(arguments, 2);
    ns = name.split(".");
    func = context;
    part = [];
    for (i = _i = 0, _len = ns.length; _i < _len; i = ++_i) {
      n = ns[i];
      part.push(n);
      if (typeof func[n] === 'undefined') {
        throw new Error("Name part `" + (part.join('.')) + "` not found while accesing " + name);
      }
      func = func[n];
    }
    return func;
  };

  this.Maslosoft.Ko.Track = (function() {
    function Track() {
      this.factory = __bind(this.factory, this);
    }

    Track.prototype.factory = function(data) {
      var className, name, ref, value;
      if (!data) {
        return data;
      }
      if (data._class) {
        className = data._class.replace(/\\/g, '.');
        ref = Maslosoft.Ko.objByName(className);
        if (ref) {
          return new ref(data);
        } else {
          console.warn("Class `" + className + "` not found, using default object");
          console.debug(data);
        }
      }
      if (typeof data === 'object') {
        for (name in data) {
          value = data[name];
          data[name] = this.factory(value);
        }
        data = ko.track(data);
      }
      return data;
    };

    return Track;

  })();

  ko.tracker = new this.Maslosoft.Ko.Track;

}).call(this);

//# sourceMappingURL=ko.balin.js.map