# utility functions to escape a query
# @param str the string to escape
escapeRegexp = (str) -> str.replace /([.?*+^$[\]\\(){}|-])/g, "\\$1"

# removes all img tags
# @param str a string possibly containing img tags
noImg = (str) -> str.replace /<img[^>]*>/g, ''

angular.module('radians.contenteditable', [])
.directive('contenteditable', ->
  require: 'ngModel',
  link: (scope, elmt, attrs, ctrl) ->
    old_render = ctrl.$render # save for later
    view_to_model = ->
      scope.$apply ->
        ctrl.$setViewValue elmt.html()
        null
      
    # view -> model
    elmt.bind 'blur', view_to_model
    elmt.bind 'input', view_to_model
    elmt.bind 'change', view_to_model

    # model -> view
    ctrl.$render = ->
      old_render() if old_render != null # old_render? leads to linted js
      elmt.html ctrl.$viewValue
      null

    null
)
.filter('typeaheadHighlight', ->
  # don't highlight anything!
  (matchItem, query) -> matchItem
)
.filter('ignoreImg', ->
  # when matching query against the items, ignore all img tags
  (items, query) ->
    item for item in items \
    when noImg(item).match(new RegExp(escapeRegexp(noImg(query)), 'gi'))
)
