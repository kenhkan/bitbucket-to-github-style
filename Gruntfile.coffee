module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    coffeelint:
      app: ["app/**/*.coffee"]
      test: ["test/**/*.coffee"]

    mochacli:
      test: ["test/**/*.coffee"]
      options:
        reporter: "spec"
        ui: "tdd"

    watch:
      app:
        files: ["app/**/*.coffee"]
        tasks: ["default"]
        options:
          nospawn: true

  grunt.loadNpmTasks "grunt-coffeelint"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-mocha-cli"

  grunt.registerTask "test", ["coffeelint", "mochacli", "watch"]
  grunt.registerTask "ci", ["coffeelint", "mochacli"]
  grunt.registerTask "default", ["test"]
