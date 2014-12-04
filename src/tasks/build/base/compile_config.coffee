path = require 'path'
cp = require 'cp'

module.exports = compileConfig = (grunt) ->
  helpers = require('../../helpers')(grunt)

  run: (fn) ->
    grunt.log.writeln 'Compiling config.xml'
    phonegapPath = helpers.config 'path'
    phonegapRoot = helpers.config 'root'
    configXml = helpers.config 'config'

    dest = path.join phonegapPath, 'www', 'config.xml'
    root = path.join phonegapRoot, 'config.xml'

    if grunt.util.kindOf(configXml) == 'string'
      grunt.log.writeln "Copying static #{configXml}"
      yield cp configXml, root
      cp configXml, dest, (err) ->
        if fn then fn(err)

    else
      grunt.log.writeln "Compiling template #{configXml.template}"
      template = grunt.file.read configXml.template
      compiled = grunt.template.process template, data: configXml.data
      grunt.file.write root, compiled
      grunt.file.write dest, compiled
      if fn then fn()
