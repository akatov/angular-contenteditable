# angular-contenteditable
[![Build Status](https://travis-ci.org/akatov/angular-contenteditable.png)](https://travis-ci.org/akatov/angular-contenteditable)

An AngularJS directive to bind html tags with the `contenteditable` attribute to models.

## Install

```bash
bower install angular-contenteditable
```

## Usage

```javascript
angular.module('myapp', ['contenteditable'])
    .controller('Ctrl', function($scope){
        $scope.model="<i>interesting</i> stuff" })
```

```html
<div ng-controller="Ctrl">
  <span contenteditable="true"
        ng-model="model"
        strip-br="true"
        select-non-editable="true"></span></div>
```

## Notice

In Chrome, when a contenteditable element X contains a non-contenteditable
element Y as the last element, then the behaviour of the caret is the following:

* When X has style `dislay` set to `block` or `inline-block`, then the caret
  moves to the very far right edge of X when it is _immediately_ at the end of X
  (inserting spaces moves the caret back).

* When X has style `display` set to `inline`, then the caret disappears instead.

## Development

```bash
npm install
bower install
grunt
```
