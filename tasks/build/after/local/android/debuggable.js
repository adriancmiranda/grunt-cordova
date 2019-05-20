(function() {
  var applicationName, path, xmldom;

  xmldom = require('xmldom');

  path = require('path');

  module.exports = applicationName = function(grunt) {
    var helpers;
    helpers = require('../../../../helpers')(grunt);
    return {
      set: function(fn) {
        var debuggable, doc, dom, manifest, manifestPath, phonegapPath;
        dom = xmldom.DOMParser;
        debuggable = helpers.config('debuggable');
        phonegapPath = helpers.config('path');
        manifestPath = helpers.config('androidManifestPath');
        manifestPath = manifestPath || 'platforms/android/CordovaLib/AndroidManifest.xml';
        manifestPath = path.join(phonegapPath, manifestPath);
        manifest = grunt.file.read(manifestPath);
        grunt.log.writeln("Setting debuggable in '" + manifestPath + "' to " + debuggable);
        doc = new dom().parseFromString(manifest, 'text/xml');
        app = doc.getElementsByTagName('application')[0];
        app.setAttribute('android:debuggable', debuggable);
        grunt.file.write(manifestPath, doc);
        if (fn) {
          return fn();
        }
      }
    };
  };

}).call(this);
