// Generated by CoffeeScript 1.9.3
(function() {
  if (!this.Maslosoft) {
    this.Maslosoft = {};
  }

  if (!this.Maslosoft.BinderDev) {
    this.Maslosoft.BinderDev = {};
  }

  this.Maslosoft.BinderDev.TitleRenderer = (function() {
    function TitleRenderer(tree, options) {}

    TitleRenderer.prototype.render = function(node, span) {
      var description;
      description = '';
      if (node.description) {
        description = "<em class='text-muted'>" + node.description + "</em>";
      }
      span.html("<b>" + node.title + "</b> " + description);
      span.attr('title', "ID: " + node.id);
      span.attr('data-placement', "right");
      return span.attr('rel', 'tooltip');
    };

    return TitleRenderer;

  })();

}).call(this);
