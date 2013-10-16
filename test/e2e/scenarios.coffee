describe 'module contenteditable', ->
  describe 'directive contenteditable', ->
    describe 'simple application', ->
      beforeEach ->
        browser().navigateTo 'base/test/fixtures/simple.html'

      it 'should update the model from the view (simple text)', ->
        element('#input').enter('abc')
        expect(element('#input').html()).toBe 'abc'
        expect(element('#output').html()).toBe 'abc'

      it 'should update the model from the view (text with spans)', ->
        element('#input').html('abc <span style="color:red">red</span>')
        expect(element('#input span').html()).toBe 'red'
        expect(element('#output').html()).toBe 'abc &lt;span style="color:red"&gt;red&lt;/span&gt;'

      it 'should update the view from the model', ->
        input('model').enter('oops')
        expect(element('#input').html()).toBe 'oops'
        expect(element('#output').html()).toBe 'oops'
        input('model').enter('a <span style="color:red">red</span> b')
        expect(element('#input').html()).toBe 'a <span style="color:red">red</span> b'
        expect(element('#input span').html()).toBe 'red'
        expect(element('#output').html()).toBe 'a &lt;span style="color:red"&gt;red&lt;/span&gt; b'
