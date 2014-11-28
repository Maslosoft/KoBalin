// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  if (!this.Maslosoft) {
    this.Maslosoft = {};
  }

  if (!this.Maslosoft.Ko.BalinDev) {
    this.Maslosoft.Ko.BalinDev = {};
  }

  if (!this.Maslosoft.Ko.BalinDev.Models) {
    this.Maslosoft.Ko.BalinDev.Models = {};
  }

  this.Maslosoft.Ko.BalinDev.Models.TreeItem = (function(_super) {
    __extends(TreeItem, _super);

    function TreeItem() {
      return TreeItem.__super__.constructor.apply(this, arguments);
    }

    TreeItem.prototype._class = "Maslosoft.Ko.BalinDev.Models.TreeItem";

    TreeItem.prototype.title = '';

    TreeItem.prototype.children = [];

    return TreeItem;

  })(this.Maslosoft.Ko.Balin.Model);

  this.Maslosoft.Ko.BalinDev.Models.Intro = (function(_super) {
    __extends(Intro, _super);

    function Intro() {
      return Intro.__super__.constructor.apply(this, arguments);
    }

    Intro.prototype._class = "Maslosoft.Ko.BalinDev.Models.Intro";

    Intro.prototype.text = '';

    return Intro;

  })(this.Maslosoft.Ko.Balin.Model);

  this.Maslosoft.Ko.BalinDev.Models.FileSizeFormatter = (function(_super) {
    __extends(FileSizeFormatter, _super);

    function FileSizeFormatter() {
      return FileSizeFormatter.__super__.constructor.apply(this, arguments);
    }

    FileSizeFormatter.prototype._class = "Maslosoft.Ko.BalinDev.Models.FileSizeFormatter";

    FileSizeFormatter.prototype.size = 0;

    return FileSizeFormatter;

  })(this.Maslosoft.Ko.Balin.Model);

  this.Maslosoft.Ko.BalinDev.Models.Href = (function(_super) {
    __extends(Href, _super);

    function Href() {
      return Href.__super__.constructor.apply(this, arguments);
    }

    Href.prototype._class = "Maslosoft.Ko.BalinDev.Models.Href";

    Href.prototype.filename = '';

    return Href;

  })(this.Maslosoft.Ko.Balin.Model);

  this.Maslosoft.Ko.BalinDev.Models.Src = (function(_super) {
    __extends(Src, _super);

    function Src() {
      return Src.__super__.constructor.apply(this, arguments);
    }

    Src.prototype._class = "Maslosoft.Ko.BalinDev.Models.Src";

    Src.prototype.filename = '';

    return Src;

  })(this.Maslosoft.Ko.Balin.Model);

  this.Maslosoft.Ko.BalinDev.Models.HtmlValue = (function(_super) {
    __extends(HtmlValue, _super);

    function HtmlValue() {
      return HtmlValue.__super__.constructor.apply(this, arguments);
    }

    HtmlValue.prototype._class = "Maslosoft.Ko.BalinDev.Models.HtmlValue";

    HtmlValue.prototype.text = '';

    return HtmlValue;

  })(this.Maslosoft.Ko.Balin.Model);

  this.Maslosoft.Ko.BalinDev.Models.TextValue = (function(_super) {
    __extends(TextValue, _super);

    function TextValue() {
      return TextValue.__super__.constructor.apply(this, arguments);
    }

    TextValue.prototype._class = "Maslosoft.Ko.BalinDev.Models.TextValue";

    TextValue.prototype.text = '';

    return TextValue;

  })(this.Maslosoft.Ko.Balin.Model);

  this.Maslosoft.Ko.BalinDev.Models.SortableHtmlValues = (function(_super) {
    __extends(SortableHtmlValues, _super);

    function SortableHtmlValues() {
      return SortableHtmlValues.__super__.constructor.apply(this, arguments);
    }

    SortableHtmlValues.prototype._class = "Maslosoft.Ko.BalinDev.Models.SortableHtmlValues";

    SortableHtmlValues.prototype.title = '';

    SortableHtmlValues.prototype.items = [];

    return SortableHtmlValues;

  })(this.Maslosoft.Ko.Balin.Model);

}).call(this);
