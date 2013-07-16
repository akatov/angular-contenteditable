# angular-contenteditable

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

## Development

```bash
npm install
grunt build
grunt karma:e2e
```
