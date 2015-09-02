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

      it 'setting the model with some pure text should dispaly <br> instead of newlines \\n', ->
        input('unformatted').enter('#h1\n\n##h2\n###h3');
        expect(element('#output-unformatted').html()).toBe '#h1<br><br>##h2<br>###h3'

      it 'putting some unformatted text with <br>s in the html should replace them with newlines', ->

        element('#output-unformatted').html('#h1<br><br>##h2<br>###h3');
        expect(input('unformatted').val()).toBe('#h1\n\n##h2\n###h3');
