basePath = '..'

files =
[ ANGULAR_SCENARIO
, ANGULAR_SCENARIO_ADAPTER
, 'src/**/*.coffee'
, 'test/e2e/**/*.coffee'
, { pattern: 'examples/simple.html'
  , watched: false
  , included: false
  , served: true }
, { pattern: 'components/angular/angular.js'
  , watched: false
  , included: false
  , served: true }
, { pattern: 'dist/radians.js'
  , watched: false
  , included: false
  , served: true }
]

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
