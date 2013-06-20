angular.module('radians.contenteditable', [])
.directive('contenteditable', ->
  require: 'ngModel',
  link: (scope, elmt, attrs, ctrl) ->
    # view -> model
    view_to_model = ->
      scope.$apply ->
        ctrl.$setViewValue elmt.html()
      
    elmt.bind 'blur', view_to_model
    elmt.bind 'input', view_to_model
    elmt.bind 'change', view_to_model

    # model -> view
    ctrl.$render = -> elmt.html ctrl.$viewValue

    null
)
