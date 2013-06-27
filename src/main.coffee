###
handy - record and view motion capture samples.

USAGE

  handy --record NUMBER_OF_FRAMES [FILENAME]
  handy FILENAME

  handy -r 1000                # stream 1000 frames to stdout 
  handy -r 1000 sample.json    # stream 1000 frames to sample.json
  handy sample.json            # view sample.json

###
audio = require './audio'
print = console.log


save = (frames, file) ->
  '''
  Save a specified number of motion frames as a sample to file.
    
  '''
  WebSocket = require 'ws'
  ws = new WebSocket 'ws://localhost:6437'
  fs = require 'fs'

  out = if file then fs.createWriteStream(file) else process.stdout 
  max = parseInt frames   # num of frames to save
  i = 0                   # num of frames seen

  ws.on 'open', -> 
    print ' leap socket opened' if file
    ws.send JSON.stringify {enableGestures: true}
    out.write '[\n'                               # opening bracket for JSON payload

  ws.on 'close', (code, reason) -> 
    out.write ']\n'                               # closing bracket for JSON payload
    if file
      print ' leap socket closed'
      print " #{ws.bytesReceived} bytes received"
      print " #{max} frames written to #{file}"
      print reason if reason

  ws.on 'error', (err) -> print err

  ws.on 'message', (d) -> 
    if i == 0                                     # first frame of stream
      print " version #{JSON.parse(d).version}"   # print (but not write) stream version
    else if max > i
      out.write "#{d},\n"                         # include trailing comma for JSON
    else if max == i
      out.write "#{d}\n"                          # exclude trailing comma for JSON
    else
      ws.close()
    i += 1                                        # increment frame count


view = (file) -> 
  '''View sample file.'''
  if not file
    print 'Please specify a sample file to view'
  else
    print "Viewing #{file}"


run = ->
  '''
  Run as a command-line script.
    
  '''
  argv = require('optimist')
    .alias('a', 'audio')
    .alias('t', 'time')
    .describe('t', 'Time in seconds to record')
    .describe('a', 'Record and save audio track')
    .argv

  fps = 42  # frames per second estimate

  handsFile = 'hands.json'
  audioFile = 'audio.mov'

  if argv._
    file = argv._[0]
    handsFile = file + '.json'
    audioFile = file + '.mov'

  if argv.time
    secs = argv.time
    frames = secs * fps
    if argv.audio
      audio.record secs, audioFile
    save frames, handsFile
  else
    view file


Handy = module.exports = {run, save, view}
