(function() {
  angular.module('radians', ['radians.contenteditable']);

}).call(this);

(function() {
  var escapeRegexp, noImg;

  escapeRegexp = function(str) {
    return str.replace(/([.?*+^$[\]\\(){}|-])/g, "\\$1");
  };

  noImg = function(str) {
    return str.replace(/<img[^>]*>/g, '');
  };

  angular.module('radians.contenteditable', []).directive('contenteditable', function() {
    return {
      require: 'ngModel',
      link: function(scope, elmt, attrs, ctrl) {
        var old_render;
        old_render = ctrl.$render;
        elmt.bind('input', function(e) {
          return scope.$apply(function() {
            return ctrl.$setViewValue(elmt.html());
          });
        });
        return ctrl.$render = function() {
          var el, el2, range, sel;
          if (old_render !== null) {
            old_render();
          }
          elmt.html(ctrl.$viewValue);
          el = elmt.get(0);
          range = document.createRange();
          sel = window.getSelection();
          if (el.childNodes.length > 0) {
            el2 = el.childNodes[el.childNodes.length - 1];
            range.setStartAfter(el2);
          } else {
            range.setStartAfter(el);
          }
          range.collapse(true);
          sel.removeAllRanges();
          return sel.addRange(range);
        };
      }
    };
  }).filter('typeaheadHighlight', function() {
    return function(matchItem, query) {
      return matchItem;
    };
  }).filter('ignoreImg', function() {
    return function(items, query) {
      var item, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = items.length; _i < _len; _i++) {
        item = items[_i];
        if (noImg(item).match(new RegExp(escapeRegexp(noImg(query)), 'gi'))) {
          _results.push(item);
        }
      }
      return _results;
    };
  });

}).call(this);
