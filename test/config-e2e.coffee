basePath = '..'

toServe = [
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

toServe =
  for file in toServe
    pattern: file
    watched: false
    included: false
    served: true

files = [
  ANGULAR_SCENARIO
  ANGULAR_SCENARIO_ADAPTER
  'src/**/*.coffee'
  'test/e2e/**/*.coffee'
].concat toServe

exclude = []

reporters = ['progress']

port = 9876

runnerPort = 9100

colors = true

logLevel = LOG_INFO

autoWatch = true

browsers = ['Chrome']

captureTimeout = 60000

singleRun = false
