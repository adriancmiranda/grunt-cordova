(function() {
  var cloneRoot, ncp, path;

  path = require('path');

  ncp = require('ncp').ncp;

  module.exports = cloneRes = function(grunt) {
    var helpers;
    helpers = require('../../helpers')(grunt);
    return {
      run: function(fn) {
        var phonegapPath, resPath;
        grunt.log.writeln('Cloning res directory');
        resPath = helpers.config('resPath');
        phonegapPath = helpers.config('path');
        return ncp(resPath, path.join(phonegapPath, 'res'), {
          stopOnError: false
        }, (function(_this) {
          return function(err) {
            if (err) {
              grunt.warn(err);
            }
            if (fn) {
              return fn(err);
            }
          };
        })(this));
      }
    };
  };

}).call(this);
