# global module:false

module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    # Metadata.
    pkg: grunt.file.readJSON 'package.json'
    banner: '/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - ' +
      '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
      '<%= pkg.homepage ? "* " + pkg.homepage + "\\n" : "" %>' +
      '* Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>;' +
      ' Licensed <%= _.pluck(pkg.licenses, "type").join(", ") %> */\n'
    meta:
      src: 'src/'
      test: 'test/'
      target: 'dist/'
    coffeelint: src:
      files: src: ['<%= meta.src %>**/*.coffee']
      options: max_line_length: level: 'warn'
    coffee: src:
      options: bare: true
      files:
        '<%= meta.target %>radians.js': [
          '<%= meta.src %>**/*.coffee'
        ]
    clean: target: src: ['<%= meta.target %>*js']
    mochacli:
      options:
        require: ['should']
        compilers: ['coffee:coffee-script']
        reporter: 'spec'
      coffee: ['test/*.coffee']

    # Task configuration.
    # concat:
    #   options:
    #     banner: '<%= banner %>'
    #     stripBanners: true
    #   dist:
    #     src: ['lib/<%= pkg.name %>.js']
    #     dest: 'dist/<%= pkg.name %>.js'
    # uglify:
    #   options:
    #     banner: '<%= banner %>'
    #   dist:
    #     src: '<%= concat.dist.dest %>'
    #     dest: 'dist/<%= pkg.name %>.min.js'
    # watch:
    #   gruntfile:
    #     files: '<%= jshint.gruntfile.src %>'
    #     tasks: ['jshint:gruntfile']
    #   lib_test:
    #     files: '<%= jshint.lib_test.src %>'
    #     tasks: ['jshint:lib_test', 'qunit']

  # These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-mocha-cli')
  grunt.loadNpmTasks('grunt-contrib-jshint')


  grunt.registerTask 'test', ['mochacli']
  grunt.registerTask 'lint', ['coffeelint']
  grunt.registerTask 'build', ['clean', 'lint']
  grunt.registerTask 'default', ['lint' , 'test', 'build', 'jshint']
