module.exports = (grunt)->
  grunt.initConfig
    cson:
      manifest:
        files:
          'build/manifest.json': ['src/manifest.cson']

    coffee:
      main:
        files:
          'build/js/github.js': ['src/github.coffee']
        options:
          bare: true

    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-cson'

    grunt.registerTask 'default', ['coffee', 'cson']
