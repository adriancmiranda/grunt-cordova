xmldom = require 'xmldom'
path = require 'path'

module.exports = sdkVersion = (grunt) ->
  helpers = require('../../../../helpers')(grunt)

  setTarget: (fn) ->
    dom = xmldom.DOMParser
    targetSdkVersion = helpers.config 'targetSdkVersion'
    if targetSdkVersion
      phonegapPath = helpers.config 'path'
      manifestPath = helpers.config 'manifestPath'
      manifestPath = manifestPath || 'platforms/android/CordovaLib/AndroidManifest.xml'
      manifestPath = path.join phonegapPath, manifestPath
      manifest = grunt.file.read manifestPath

      grunt.log.writeln "Setting targetSdkVersion to #{targetSdkVersion} in '#{manifestPath}'"

      doc = new dom().parseFromString manifest, 'text/xml'
      doc.getElementsByTagName('uses-sdk')[0].setAttribute('android:targetSdkVersion', targetSdkVersion)
      grunt.file.write manifestPath, doc

    if fn then fn()

  setMin: (fn) ->
    dom = xmldom.DOMParser
    minSdkVersion = helpers.config 'minSdkVersion'
    if minSdkVersion
      phonegapPath = helpers.config 'path'

      manifestPath = path.join phonegapPath, 'platforms/android/CordovaLib/AndroidManifest.xml'
      manifest = grunt.file.read manifestPath

      grunt.log.writeln "Setting minSdkVersion to #{minSdkVersion} in '#{manifestPath}'"

      doc = new dom().parseFromString manifest, 'text/xml'
      doc.getElementsByTagName('uses-sdk')[0].setAttribute('android:minSdkVersion', minSdkVersion)
      grunt.file.write manifestPath, doc

    if fn then fn()
