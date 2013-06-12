angular.module('radians.contenteditable', [])
.directive('contenteditable', ->
  require: 'ngModel',
  link: (scope, elm, attrs, ctrl) ->
    # view -> model
    elm.bind 'blur', ->
      console.log elm
      console.log "blur()"
      scope.$apply ->
        ctrl.$setViewValue elm.html()

    elm.bind 'input', (e) ->
      console.log 'input', e
      t = elm.html()
      console.log 'elm contents', t
      scope.$apply ->
        ctrl.$setViewValue t

    # model -> view
    ctrl.$render = (v) ->
      console.log @
      console.log "model: #{@$modelValue}, view: #{@$viewValue}"
      console.log "$render()", v
      elm.html ctrl.$viewValue
)
