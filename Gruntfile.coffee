# global module:false

module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    meta:
      src: 'src'
      test: 'test'
      banner: '/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - ' +
        '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
        '<%= pkg.homepage ? "* " + pkg.homepage + "\\n" : "" %>' +
        '* Copyright (c) <%= grunt.template.today("yyyy") %>' +
        ' <%= pkg.author.name %>;' +
        ' Licensed <%= _.pluck(pkg.licenses, "type").join(", ") %> */\n'
    clean: target: src: ['<%= pkg.title %>.js']
    coffeelint:
      src:
        files: src: ['<%= meta.src %>/**/*.coffee']
        options: max_line_length: level: 'warn'
      test:
        files: src: ['<%= meta.src %>/**/*.coffee']
        options: max_line_length: level: 'warn'
      gruntfile:
        files: src: ['Gruntfile.coffee']
    coffee: src:
      files:
        '<%= pkg.name %>.js': [
          '<%= meta.src %>/**/*.coffee'
        ]
    karma:
      # unit: configFile: 'config/karma-unit.coffee'
      e2e: configFile: 'config/karma-e2e.coffee'
      # unit_ci:
      #   configFile: 'config/karma-unit.coffee'
      #   singleRun: true
      #   browsers: ['PhantomJS']
      e2e_ci:
        configFile: 'config/karma-e2e.coffee'
        singleRun: true
        browsers: ['PhantomJS']
    jshint: target: ['<%= pkg.name %>.js']

  require('matchdep').filterDev('grunt-*').forEach grunt.loadNpmTasks

  grunt.registerTask 'test', ['karma:e2e_ci']
  grunt.registerTask 'lint', ['coffeelint']
  grunt.registerTask 'build', ['clean', 'coffee']
  grunt.registerTask 'default', ['lint' , 'test', 'build', 'jshint']
