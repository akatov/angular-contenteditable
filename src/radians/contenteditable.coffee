angular.module('radians.contenteditable', [])
.directive('contenteditable', ->
  require: 'ngModel',
  link: (scope, elm, attrs, ctrl) ->
    # view -> model
    view_to_model = ->
      scope.$apply ->
        ctrl.$setViewValue elm.html()
      
    elm.bind 'blur', view_to_model
    elm.bind 'input', view_to_model
    elm.bind 'change', view_to_model

    # model -> view
    ctrl.$render = -> elm.html ctrl.$viewValue
)
