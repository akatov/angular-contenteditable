angular.module('contenteditable', [])
.directive('contenteditable', ->
  require: 'ngModel',
  link: (scope, elmt, attrs, ngModel) ->
    # view -> model
    elmt.bind 'input', (e) ->
      scope.$apply ->
        html = elmt.html()
        html = '' if attrs.stripBr && attrs.stripBr != "false" && html == '<br>'
        ngModel.$setViewValue(html)

    # model -> view
    old_render = ngModel.$render # save for later
    ngModel.$render = ->
      old_render() if old_render?
      elmt.html(ngModel.$viewValue || '')
      # move cursor to the end
      el = elmt.get(0)
      range = document.createRange()
      sel = window.getSelection()
      if el.childNodes.length > 0
        el2 = el.childNodes[el.childNodes.length - 1]
        range.setStartAfter(el2)
      else
        range.setStartAfter(el)
      range.collapse(true)
      sel.removeAllRanges()
      sel.addRange(range)
)
