xmldom = require 'xmldom'
path = require 'path'

module.exports = applicationName = (grunt) ->
  helpers = require('../../../../helpers')(grunt)

  set: (fn) ->
    dom = xmldom.DOMParser
    name = helpers.config 'androidApplicationName'
    if name
      phonegapPath = helpers.config 'path'
      manifestPath = helpers.config 'androidManifestPath'
      manifestPath = manifestPath || 'platforms/android/CordovaLib/AndroidManifest.xml'

      manifestPath = path.join phonegapPath, manifestPath
      manifest = grunt.file.read manifestPath
      grunt.log.writeln "Setting application name in '#{manifestPath}' to #{name}"
      doc = new dom().parseFromString manifest, 'text/xml'

      doc.getElementsByTagName('application')[0].setAttribute('android:name', name)

      grunt.file.write manifestPath, doc

    if fn then fn()
