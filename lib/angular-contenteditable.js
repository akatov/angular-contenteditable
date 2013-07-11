(function() {
  angular.module('contenteditable', []).directive('contenteditable', function() {
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
  });

}).call(this);
