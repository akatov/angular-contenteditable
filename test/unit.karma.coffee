module.exports = (karma) ->
  karma.set
    basePath: '..'

    frameworks: ['mocha']

    files: [
      'bower_components/angular/angular.js'
      'angular-contenteditable.js'
      'test/unit/*.coffee'
    ]

    preprocessors: '**/*.coffee': 'coffee'

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
