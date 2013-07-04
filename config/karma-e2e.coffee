basePath = '..'

toServe = [
  'components/jquery/jquery.js'
  'components/angular/angular.js'
  'components/angular-bootstrap/ui-bootstrap.js'
  'components/angular-bootstrap/ui-bootstrap-tpls.js'
  'angular-radians.js'
  'examples/simple.html'
  'examples/typeahead1.html'
  'examples/typeahead2.html'
  'examples/typeahead3.html'
  'examples/states.json'
  'examples/img/ru.gif'
  'examples/img/gb.gif'
  'examples/img/us.gif'
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
