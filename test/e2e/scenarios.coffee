angular.scenario.dsl 'contenteditable', ->
  (name) ->
    @name = name
    enter: (value) ->
      @addFutureAction "contenteditable '#{@name}' enter '#{value}'"
      , ($window, $document, done) ->
        elmt = $document.elements @name
        elmt.text value
        elmt.trigger 'input'
        done()
    html: (args...) ->
      futureName =
        if args.length == 0
          "contenteditable '#{@name}' html"
        else
          "contenteditable '#{@name}' set html to '#{args[0]}'"
      @addFutureAction futureName
      , ($window, $document, done) ->
        elmt = $document.elements @name
        elmt.html args
        elmt.trigger 'change'
        done(null, elmt.html(args))

angular.scenario.dsl 'scope', ->
  (ctrl, arg = null) ->
    futureName =
      if !arg?
        "scope in Controller '#{ctrl}'"
      else if typeof arg == 'function'
        "executing 'scope.$apply(#{arg})' in Controller '#{ctrl}'"
      else
        "scope variable '#{arg}' in Controller '#{ctrl}'"
    @addFutureAction futureName
    , ($window, $document, done) ->
      elmt = $window.$ "[ng-controller='#{ctrl}']"
      return done("No Controller #{ctrl}") unless elmt?
      sc = elmt.scope()
      return done(null, sc) unless arg?
      if typeof arg == 'string'
        parts = arg.split '.'
        for p in parts
          sc = sc[p]
        done(null, sc)
      else if typeof arg == 'function'
        sc.$apply -> arg(sc)
        done()
      else
        done "don't understand argument #{arg}"

describe 'radians', ->
  describe 'contenteditable', ->
    describe 'simple application', ->
      beforeEach ->
        browser().navigateTo 'base/examples/simple.html'

      it 'should update the model from the view (simple text)', ->
        contenteditable('#input').enter('abc')
        expect(element('#input').html()).toBe 'abc'
        expect(scope('Ctrl', 'model')).toBe 'abc'
        expect(element('#output').html()).toBe 'abc'

      it 'should update the model from the view (text with spans)', ->
        contenteditable('#input').html('abc <span style="color:red">red</span>')
        expect(scope('Ctrl', 'model')).toBe 'abc <span style="color:red">red</span>'
        expect(element('#input span').html()).toBe 'red'
        expect(element('#output').html()).toBe 'abc &lt;span style="color:red"&gt;red&lt;/span&gt;'

      it 'should update the view from the model', ->
        expect(scope('Ctrl', 'model')).toBe 'Initial stuff <b>with bold</b> <em>and italic</em> yay'
        scope('Ctrl', ($scope) -> $scope.model = 'oops')
        expect(scope('Ctrl', 'model')).toBe 'oops'
        expect(element('#input').html()).toBe 'oops'
        scope('Ctrl', ($scope) -> $scope.model = 'a <span style="color:red">red</span> b')
        expect(element('#input').html()).toBe 'a <span style="color:red">red</span> b'
        expect(element('#input span').html()).toBe 'red'

        ## Why doesn't it work on this one??!!
        # expect(element('#output').html()).toBe 'oops'
