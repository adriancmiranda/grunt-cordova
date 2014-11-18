module.exports = serve = (grunt) ->
  helpers = require('./helpers')(grunt)
  
  # Use a local SDK to build and install your application
  # for a specific platform.
  # 
  # @param [String] platform The platform to build and serve on
  # @param [String] device One of `$ adb devices` or "emulator"
  # @param [Function] fn Optional callback to serve when the child process terminates.
  local = (platform, device, fn) ->
    cmd = "phonegap serve"
    helpers.exec cmd, fn

  serve: (platform, device, fn) ->
    local platform, device, fn
