_ = require 'lodash'
async = require 'async'

module.exports = (grunt) ->

  defaults =
    root: 'www'
    config: 'config.xml'
    path: 'build'
    cleanBeforeBuild: true
    cordova: '.cordova'
    plugins: []
    platforms: []
    maxBuffer: 200
    name: ->
      pkg = grunt.file.readJSON 'package.json'
      pkg.name
    verbose: false
    releases: 'releases'
    releaseName: ->
      pkg = grunt.file.readJSON 'package.json'
      "#{pkg.name}-#{pkg.version}"
    key:
      store: 'release.keystore'
      alias: 'release'
      aliasPassword: -> ''
      storePassword: -> ''
    versionCode: -> 1
    debuggable: false
    remote: {}

  grunt.registerTask 'cordova:build', 'Build as a Phonegap application', (platform) ->
    helpers = require('./helpers')(grunt)
    helpers.mergeConfig defaults
    build = require('./build')(grunt)

    platforms = if platform then [platform] else helpers.config 'platforms'

    done = @async()
    build.run platforms, (err, result) ->
      if err then grunt.fatal err
      done()
  
  grunt.registerTask 'cordova:serve', 'Serve a Phonegap application', ->
    helpers = require('./helpers')(grunt)
    helpers.mergeConfig defaults
    serve = require('./serve')(grunt)

    platform = @args[0] || _.first(grunt.config.get('cordova.config.platforms'))
    device  = @args[1] || ''

    done = @async()
    serve.serve platform, device, -> done()

  grunt.registerTask 'cordova:run', 'Run a Phonegap application', ->
    helpers = require('./helpers')(grunt)
    helpers.mergeConfig defaults
    run = require('./run')(grunt)

    platform = @args[0] || _.first(grunt.config.get('cordova.config.platforms'))
    device  = @args[1] || ''

    done = @async()
    run.run platform, device, -> done()

  grunt.registerTask 'cordova:release', 'Create a distributable release', ->
    helpers = require('./helpers')(grunt)
    helpers.mergeConfig defaults
    release = require('./release')(grunt)

    platform = @args[0] || _.first(grunt.config.get('cordova.config.platforms'))
    done = @async()
    release.on platform, -> done()

  grunt.registerTask 'cordova:debug', 'Create a debug release', ->
    helpers = require('./helpers')(grunt)
    helpers.mergeConfig defaults
    debug = require('./debug')(grunt)

    platform = @args[0] || _.first(grunt.config.get('cordova.config.platforms'))
    done = @async()
    debug.on platform, -> done()

  grunt.registerTask 'cordova:login', 'Log into the remote build service', ->
    helpers = require('./helpers')(grunt)
    helpers.mergeConfig defaults

    grunt.config.requires 'cordova.config.remote.username'
    grunt.config.requires 'cordova.config.remote.password'

    username = grunt.config.get 'cordova.config.remote.username'
    password = grunt.config.get 'cordova.config.remote.password'

    done = @async()
    cmd = "cordova remote login --username #{username} --password #{password}"
    helpers.exec cmd, -> done()

  grunt.registerTask 'cordova:logout', 'Log out of the remote build service', ->
    helpers = require('./helpers')(grunt)
    helpers.mergeConfig defaults
    done = @async()
    helpers.exec 'cordova remote logout', -> done()
