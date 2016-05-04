// Generated by CoffeeScript 1.9.3
(function() {
  var doRound, elem, settings,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  this.Maslosoft.Ko.BalinDev.Models.Settings = (function(superClass) {
    extend(Settings, superClass);

    function Settings() {
      return Settings.__super__.constructor.apply(this, arguments);
    }

    Settings.prototype._class = 'Maslosoft.Ko.BalinDev.Models.Settings';

    Settings.prototype.lang = {};

    return Settings;

  })(Maslosoft.Ko.Balin.Model);

  settings = new Maslosoft.Ko.BalinDev.Models.Settings;

  settings.lang.en = 'English';

  settings.lang.pl = 'Polish';

  app.model.settings = settings;

  ko.track(app.model);

  ko.applyBindings({
    model: app.model
  });

  doRound = function() {
    var index, json, model, res, results;
    json = JSON.stringify(app.model);
    res = JSON.parse(json);
    console.log(res);
    results = [];
    for (index in res) {
      model = res[index];
      if (!!app.model[index]) {
        results.push(ko.tracker.fromJs(app.model[index], res[index]));
      } else {
        results.push(app.model[index] = ko.tracker.factory(res[index]));
      }
    }
    return results;
  };

  elem = jQuery('#dynamicPropertiesTest');

  describe('Test if will allow use of dynamic properties and do round-trip', function() {
    it('if will allow adding element', function() {
      settings = app.model.settings;
      assert.equal(Object.keys(settings.lang).length, 2);
      settings.lang.fr = 'Francaise';
      settings.lang.de = 'Deutch';
      assert.equal(Object.keys(settings.lang).length, 4);
      assert.equal(elem.find('div').length, 4, 'That DOM elements are 4 before round trip');
      doRound();
      assert.equal(Object.keys(settings.lang).length, 4, 'That there are still 4 languages');
      return assert.equal(elem.find('div').length, 4, 'That DOM elements are 4 after round trip');
    });
    return it('if will allow removing element', function() {
      settings = app.model.settings;
      assert.equal(Object.keys(settings.lang).length, 4);
      delete settings.lang.fr;
      delete settings.lang.de;
      delete settings.lang.pl;
      settings.lang.en = 'foo';
      assert.equal(Object.keys(settings.lang).length, 1);
      assert.equal(elem.find('div').length, 1, 'That DOM elements are 1 before round trip');
      doRound();
      assert.equal(Object.keys(settings.lang).length, 1, 'That there are now 1 languages');
      assert.equal(elem.find('div').length, 1, 'That DOM elements are 1 after round trip');
      return assert.equal(elem.find('div')[0].innerHTML, 'foo', 'That DOM elements is changed to foo');
    });
  });

}).call(this);
