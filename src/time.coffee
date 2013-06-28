fs = require 'fs'
print = console.log 

calc = (data) ->
  '''Calculate timing info for data sample.'''
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
  '''Print timing info for data sample.'''
  if err
    print err
  else
    print calc data

exports.info = (file, done=show) -> fs.readFile file, 'utf8', done
