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
