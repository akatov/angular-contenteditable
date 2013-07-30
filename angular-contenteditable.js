angular.module('contenteditable', [])
    .directive('contenteditable', function() { return {
        require: 'ngModel',
        link: function($scope, $element, attrs, ngModel) {
            var old_render;
            // view -> model
            $element.bind('input', function(e) {
                $scope.$apply(function() {
                    var html, html2, rerender;
                    html = $element.html();
                    rerender = false;
                    if (attrs.stripBr && attrs.stripBr !== "false") {
                        html = html.replace(/<br>$/, '');
                    }
                    if (attrs.noLineBreaks && attrs.noLineBreaks !== "false") {
                        html2 = html.replace(/<div>/g, '').replace(/<br>/g, '').replace(/<\/div>/g, '');
                        if (html2 !== html) {
                            rerender = true;
                            html = html2;
                        }
                    }
                    ngModel.$setViewValue(html);
                    if (rerender) {
                        ngModel.$render();
                    }
                    if (html === '') {
                        // the cursor disappears if the contents is empty
                        // so we need to refocus
                        $element.blur();
                        $element.focus();
                    }
                });
            });

            // model -> view
            old_render = ngModel.$render;
            ngModel.$render = function() {
                var el, el2, range, sel;
                if (!!old_render) {
                    old_render();
                }
                $element.html(ngModel.$viewValue || '');
                el = $element.get(0);
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
                sel.addRange(range);
            };
            if (attrs.selectNonEditable && attrs.selectNonEditable !== "false") {
                $element.click(function(e) {
                    var range, sel, target;
                    target = e.toElement;
                    if (target !== this && angular.element(target).attr('contenteditable') === 'false') {
                        range = document.createRange();
                        sel = window.getSelection();
                        range.setStartBefore(target);
                        range.setEndAfter(target);
                        sel.removeAllRanges();
                        sel.addRange(range);
                    }
                });
            }
        }
    };});

