(function() {
  var serve;

  module.exports = serve = function(grunt) {
    var helpers, local, remote;
    helpers = require('./helpers')(grunt);
    local = function(platform, device, fn) {
      var cmd, cwd;
      cmd = "cordova serve";
      cwd = grunt.config.get('phonegap.config.path');
      return helpers.exec(cmd, fn, cwd);
    };
    return {
      serve: function(platform, device, fn) {
        return local(platform, device, fn);
      }
    };
  };

}).call(this);
