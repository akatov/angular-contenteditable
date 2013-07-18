angular.module('contenteditable', [])
.directive('contenteditable', ->
  require: 'ngModel',
  link: (scope, elmt, attrs, ngModel) ->
    # view -> model
    elmt.bind 'input', (e) ->
      scope.$apply ->
        html = elmt.html()
        rerender = false
        if attrs.stripBr && attrs.stripBr != "false"
          html = html.replace /<br>$/, ''
        if attrs.noLineBreaks && attrs.noLineBreaks != "false"
          html = html.replace(/<div>/g, '').replace(/<br>/g, '').replace(/<\/div>/g, '')
          rerender = true
        ngModel.$setViewValue(html)
        ngModel.$render() if rerender
        if html == '' # the cursor if the contents is emty, so need to refocus
          elmt.blur()
          elmt.focus()

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

    # select whole sub-span if it has contenteditable="false"
    if attrs.selectNonEditable && attrs.selectNonEditable != "false"
      elmt.click (e) ->
        target = e.toElement
        if target != @ && angular.element(target).attr('contenteditable') == 'false'
          range = document.createRange()
          sel = window.getSelection()
          range.setStartBefore(target)
          range.setEndAfter(target)
          sel.removeAllRanges()
          sel.addRange(range)
)
