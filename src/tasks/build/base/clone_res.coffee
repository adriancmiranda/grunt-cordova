path = require 'path'
ncp = require('ncp').ncp

module.exports = cloneRes = (grunt) ->
  helpers = require('../../helpers')(grunt)
  run: (fn) ->
    grunt.log.writeln 'Cloning res directory'
    resPath = helpers.config 'resPath'
    phonegapPath = helpers.config 'path'

    ncp resPath, path.join(phonegapPath, 'res'), { stopOnError: false }, (err) =>
      if err then grunt.warn err
      if fn then fn err
