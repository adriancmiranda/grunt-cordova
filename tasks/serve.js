(function() {
  var serve;

  module.exports = serve = function(grunt) {
    var helpers, local, remote;
    helpers = require('./helpers')(grunt);
    local = function(platform, device, fn) {
      var cmd;
      cmd = "phonegap serve";
      return helpers.exec(cmd, fn);
    };
    return {
      serve: function(platform, device, fn) {
        return local(platform, device, fn);
      }
    };
  };

}).call(this);
