module.exports = (karma) ->
  toServe = for file in [
    'bower_components/**/*.css'
    'bower_components/*/*.js'
    'test/fixtures/**/*'
  ]
    pattern: file
    watched: false
    included: false
    served: true

  karma.set
    basePath: '..'

    frameworks: ['ng-scenario']

    preprocessors: '**/*.coffee': 'coffee'

    files: [
      'test/e2e/**/*.coffee'
      'angular-contenteditable.js'
    ].concat toServe

    exclude: []

    reporters: ['progress']

    port: 9876

    runnerPort: 9100

    colors: true

    logLevel: karma.LOG_INFO

    autoWatch: true

    browsers: ['Chrome']

    captureTimeout: 60000

    singleRun: false
