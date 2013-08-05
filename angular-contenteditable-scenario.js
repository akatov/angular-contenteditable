
/**
 * we copied most of the 'element' scenario dsl so we can keep the old actions
 * and also add the 'enter' and modified 'html' actions.
 * @see https://github.com/angular/angular.js/blob/master/src/ngScenario/dsl.js
 * @see http://stackoverflow.com/questions/12575199/how-to-test-a-contenteditable-field-based-on-a-td-using-angularjs-e2e-testing
 *
 * Usage:
 *    element(selector, label).count() get the number of elements that match selector
 *    element(selector, label).click() clicks an element
 *    element(selector, label).mouseover() mouseover an element
 *    element(selector, label).mousedown() mousedown an element
 *    element(selector, label).mouseup() mouseup an element
 *    element(selector, label).query(fn) executes fn(selectedElements, done)
 *    element(selector, label).{method}() gets the value (as defined by jQuery, ex. val)
 *    element(selector, label).{method}(value) sets the value (as defined by jQuery, ex. val)
 *    element(selector, label).{method}(key) gets the value (as defined by jQuery, ex. attr)
 *    element(selector, label).{method}(key, value) sets the value (as defined by jQuery, ex. attr)
 *    element(selector, label).enter(value) sets the text if the element is contenteditable
 */
angular.scenario.dsl('element', function() {
  var KEY_VALUE_METHODS = ['attr', 'css', 'prop'];
  var VALUE_METHODS = [
    'val', 'text', 'html', 'height', 'innerHeight', 'outerHeight', 'width',
    'innerWidth', 'outerWidth', 'position', 'scrollLeft', 'scrollTop', 'offset'
  ];
  var chain = {};

  chain.count = function() {
    return this.addFutureAction("element '" + this.label + "' count", function($window, $document, done) {
      try {
        done(null, $document.elements().length);
      } catch (e) {
        done(null, 0);
      }
    });
  };

  chain.click = function() {
    return this.addFutureAction("element '" + this.label + "' click", function($window, $document, done) {
      var elements = $document.elements();
      var href = elements.attr('href');
      var eventProcessDefault = elements.trigger('click')[0];

      if (href && elements[0].nodeName.toUpperCase() === 'A' && eventProcessDefault) {
        this.application.navigateTo(href, function() {
          done();
        }, done);
      } else {
        done();
      }
    });
  };

  chain.dblclick = function() {
    return this.addFutureAction("element '" + this.label + "' dblclick", function($window, $document, done) {
      var elements = $document.elements();
      var href = elements.attr('href');
      var eventProcessDefault = elements.trigger('dblclick')[0];

      if (href && elements[0].nodeName.toUpperCase() === 'A' && eventProcessDefault) {
        this.application.navigateTo(href, function() {
          done();
        }, done);
      } else {
        done();
      }
    });
  };

  chain.mouseover = function() {
    return this.addFutureAction("element '" + this.label + "' mouseover", function($window, $document, done) {
      var elements = $document.elements();
      elements.trigger('mouseover');
      done();
    });
  };

  chain.mousedown = function() {
      return this.addFutureAction("element '" + this.label + "' mousedown", function($window, $document, done) {
        var elements = $document.elements();
        elements.trigger('mousedown');
        done();
      });
    };

  chain.mouseup = function() {
      return this.addFutureAction("element '" + this.label + "' mouseup", function($window, $document, done) {
        var elements = $document.elements();
        elements.trigger('mouseup');
        done();
      });
    };

  chain.query = function(fn) {
    return this.addFutureAction('element ' + this.label + ' custom query', function($window, $document, done) {
      fn.call(this, $document.elements(), done);
    });
  };

  angular.forEach(KEY_VALUE_METHODS, function(methodName) {
    chain[methodName] = function(name, value) {
      var args = arguments,
          futureName = (args.length == 1)
              ? "element '" + this.label + "' get " + methodName + " '" + name + "'"
              : "element '" + this.label + "' set " + methodName + " '" + name + "' to " + "'" + value + "'";

      return this.addFutureAction(futureName, function($window, $document, done) {
        var element = $document.elements();
        done(null, element[methodName].apply(element, args));
      });
    };
  });

  angular.forEach(VALUE_METHODS, function(methodName) {
    chain[methodName] = function(value) {
      var args = arguments,
          futureName = (args.length == 0)
              ? "element '" + this.label + "' " + methodName
              : futureName = "element '" + this.label + "' set " + methodName + " to '" + value + "'";

      return this.addFutureAction(futureName, function($window, $document, done) {
        var element = $document.elements();
        done(null, element[methodName].apply(element, args));
      });
    };
  });

  // =============== These are the methods ================ \\
  chain.enter = function(value) {
    return this.addFutureAction("element '" + this.label + "' enter '" + value + "'", function($window, $document, done) {
      var element = $document.elements()
      if (element.is('[contenteditable=""]')
          || (element.attr('contenteditable')
              && element.attr('contenteditable').match(/true/i))) {
        element.text(value)
        element.trigger('input')
      }
      done()
    })
  }

  chain.html = function(value) {
    var args = arguments,
        futureName = (args.length == 0)
          ? "element '" + this.label + "' html"
          : futureName = "element '" + this.label + "' set html to '" + value + "'";
    return this.addFutureAction(futureName, function($window, $document, done) {
      var element = $document.elements();
      element.html.apply(element, args)
      if (args.length > 0
          && (element.is('[contenteditable=""]')
              || (element.attr('contenteditable')
                  && element.attr('contenteditable').match(/true/i)))) {
        element.trigger('input')
      }
      done(null, element.html.apply(element, args));
    });
  };

  return function(selector, label) {
    this.dsl.using(selector, label);
    return chain;
  };
});
