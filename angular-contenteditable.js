(function() {
  angular.module('contenteditable', []).directive('contenteditable', function() {
    return {
      require: 'ngModel',
      link: function(scope, elmt, attrs, ngModel) {
        var old_render;
        elmt.bind('input', function(e) {
          return scope.$apply(function() {
            var html;
            html = elmt.html();
            if (attrs.stripBr && attrs.stripBr !== "false" && html === '<br>') {
              html = '';
            }
            return ngModel.$setViewValue(html);
          });
        });
        old_render = ngModel.$render;
        ngModel.$render = function() {
          var el, el2, range, sel;
          if (old_render != null) {
            old_render();
          }
          elmt.html(ngModel.$viewValue || '');
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
        if (attrs.selectNonEditable && attrs.selectNonEditable !== "false") {
          return elmt.click(function(e) {
            var range, sel, target;
            target = e.toElement;
            if (target !== this && angular.element(target).attr('contenteditable') === 'false') {
              range = document.createRange();
              sel = window.getSelection();
              range.setStartBefore(target);
              range.setEndAfter(target);
              sel.removeAllRanges();
              return sel.addRange(range);
            }
          });
        }
      }
    };
  });

}).call(this);
