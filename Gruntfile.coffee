# global module:false

module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    meta:
      test: 'test'
    karma:
      e2e: configFile: 'karma.coffee'
      e2e_ci:
        configFile: 'karma.coffee'
        singleRun: true
        browsers: ['PhantomJS']
    jshint:
      src: ['angular-contenteditable.js']
      options:
        asi: true

  require('matchdep').filterDev('grunt-*').forEach grunt.loadNpmTasks

  grunt.registerTask 'test', ['karma:e2e_ci']
  grunt.registerTask 'lint', ['jshint']
  grunt.registerTask 'default', ['lint' , 'test']
