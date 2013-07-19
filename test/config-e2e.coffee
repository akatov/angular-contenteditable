module.exports = (config) ->
  toServe = for file in [
    'components/bootstrap-css/css/bootstrap.css'
    'components/jquery/jquery.js'
    'components/angular-unstable/angular.js'
    'components/angular-bootstrap/ui-bootstrap.js'
    'components/angular-bootstrap/ui-bootstrap-tpls.js'
    'angular-contenteditable.js'
    'test/fixtures/simple.html'
    'test/fixtures/typeahead1.html'
    'test/fixtures/typeahead2.html'
    'test/fixtures/typeahead3.html'
    'test/fixtures/states.json'
    'test/fixtures/img/ru.gif'
    'test/fixtures/img/gb.gif'
    'test/fixtures/img/us.gif'
  ]
    pattern: file
    watched: false
    included: false
    served: true

  config.set
    basePath: '..'

    frameworks: ['ng-scenario']

    preprocessors: '**/*.coffee': 'coffee'

    files: [
      'test/e2e/**/*.coffee'
    ].concat toServe

    exclude: []

    reporters: ['progress']

    port: 9876

    runnerPort: 9100

    colors: true

    logLevel: config.LOG_INFO

    autoWatch: true

    browsers: ['Chrome']

    captureTimeout: 60000

    singleRun: false
