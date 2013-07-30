# global module:false

module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    meta:
      test: 'test'
    karma:
      unit: configFile: 'test/unit.karma.coffee'
      e2e: configFile: 'test/e2e.karma.coffee'
      unit_ci:
        configFile: 'test/unit.karma.coffee'
        singleRun: true
        browsers: ['PhantomJS']
      e2e_ci:
        configFile: 'test/e2e.karma.coffee'
        singleRun: true
        browsers: ['PhantomJS']
    jshint: src: ['angular-contenteditable.js']

  require('matchdep').filterDev('grunt-*').forEach grunt.loadNpmTasks

  grunt.registerTask 'test', ['karma:e2e_ci']
  grunt.registerTask 'lint', ['jshint']
  grunt.registerTask 'default', ['lint' , 'test']
