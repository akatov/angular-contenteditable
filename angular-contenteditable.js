/**
 * @see http://docs.angularjs.org/guide/concepts
 * @see http://docs.angularjs.org/api/ng.directive:ngModel.NgModelController
 * @see https://github.com/angular/angular.js/issues/528#issuecomment-7573166
 */

angular.module('contenteditable', [])
  .directive('contenteditable', ['$timeout', function($timeout) {
    return {
      restrict: 'A',
      require: '?ngModel',
      link: function(scope, element, attrs, ngModel) {
        // don't do anything unless this is actually bound to a model
        if (!ngModel) {
          return
        }

        // options
        var opts = {}
        angular.forEach([
          'stripBr',
          'noLineBreaks',
          'selectNonEditable',
          'moveCaretToEndOnChange',
          'placeholder'
        ], function(opt) {
          var o = attrs[opt]
          opts[opt] = o && o !== 'false'
        })
        if (opts.placeholder) {
          opts.placeholder = attrs.placeholder || 'Empty'
        }

        // view -> model
        function readViewValue() {
          var html, html2, rerender
          html = element.html()
          rerender = false
          if (opts.stripBr) {
            html = html.replace(/<br>$/, '')
          }
          if (opts.noLineBreaks) {
            html2 = html.replace(/<div>/g, '').replace(/<br>/g, '').replace(/<\/div>/g, '')
            if (html2 !== html) {
              rerender = true
              html = html2
            }
          }
          ngModel.$setViewValue(html)
          if (rerender) {
            ngModel.$render(true)
          }
          return html;
        }

        element.bind('input', function(e) {
          scope.$apply(function() {
            var empty = '' === readViewValue()
            if (empty) {
              // the cursor disappears if the contents is empty
              // so we need to keep focus
              selectAll(element[0])
            } else if (opts.placeholder) {
              element.removeClass('placeholder')
            }
          })
        })
        if (opts.placeholder) {
          element.bind('blur', function (e) {
            scope.$apply(function () {
              if (readViewValue() === '') {
                element.html(opts.placeholder)
                element.addClass('placeholder')
              }
            });
          })
        }

        // model -> view
        var oldRender = ngModel.$render
        ngModel.$render = function(ignorePlaceholder) {
          var el, el2, range, sel
          if (!!oldRender) {
            oldRender()
          }
          var value = ngModel.$viewValue || '';
          if (!ignorePlaceholder && opts.placeholder) {
            element.toggleClass('placeholder', value === '');
            if (value === '') {
              value = opts.placeholder;
            }
          }
          element.html(value);

          if (opts.moveCaretToEndOnChange) {
            el = element[0]
            range = document.createRange()
            sel = window.getSelection()
            if (el.childNodes.length > 0) {
              el2 = el.childNodes[el.childNodes.length - 1]
              range.setStartAfter(el2)
            } else {
              range.setStartAfter(el)
            }
            range.collapse(true)
            sel.removeAllRanges()
            sel.addRange(range)
          }
        }
        if (opts.placeholder) {
          element.bind('focus', function () {
            if (!ngModel.$viewValue) {
              element.html('')
              selectAll(element[0])
            }
          })
        }

        if (opts.selectNonEditable) {
          element.bind('click', function(e) {
            var range, sel, target
            target = e.toElement
            if (target !== this && angular.element(target).attr('contenteditable') === 'false') {
              selectAll(target)
            }
          })
        }
      }
    }

    function selectAll(node) {
      var range = document.createRange()
      range.selectNodeContents(node)
      var sel = window.getSelection()
      sel.removeAllRanges()
      sel.addRange(range)
    }
  }]);
