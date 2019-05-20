xmldom = require 'xmldom'
path = require 'path'

module.exports = versionCode = (grunt) ->
  helpers = require('../../../../helpers')(grunt)

  repair: (fn) ->
    dom = xmldom.DOMParser
    versionCode = helpers.config 'versionCode'
    if versionCode
      phonegapPath = helpers.config 'path'
      manifestPath = helpers.config 'androidManifestPath'
      manifestPath = manifestPath || 'platforms/android/CordovaLib/AndroidManifest.xml';

      manifestPath = path.join phonegapPath, manifestPath
      manifest = grunt.file.read manifestPath

      grunt.log.writeln "Setting versionCode to #{versionCode} in '#{manifestPath}'"

      doc = new dom().parseFromString manifest, 'text/xml'
      doc.getElementsByTagName('manifest')[0].setAttribute('android:versionCode', versionCode)
      grunt.file.write manifestPath, doc

    if fn then fn()
