#!/usr/bin/env coffee 
#
# Show the time-related info for a leap gesture sample:
#
#   frames - number of frames
#   seconds - number of seconds
#   FPS - frames per second
#
# Usage:
#
#   timing.coffee sample.json
#
fs = require 'fs'
print = console.log 

calc = (data) ->
  frames = JSON.parse(data)
  last = frames.length - 1
  start = frames[0].timestamp
  stop = frames[last].timestamp
  secs = (stop - start) / 1000000
  info =
    frames: frames.length
    seconds: secs
    FPS: frames.length / secs

show = (err, data) ->
  if err
    print err
  else
    print calc data

info = (file, done=show) -> fs.readFile file, 'utf8', done

file = process.argv.pop()
info file
