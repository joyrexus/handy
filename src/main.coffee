fs = require 'fs'
path = require 'path'
time = require './time'
audio = require './audio'
minty = require './minty'
{open} = require './util'

print = console.log
data = {} # passed to template for interpolation


save = (frames, file) ->
  '''
  Save a specified number of motion frames as a sample to file.
    
  '''
  WebSocket = require 'ws'
  ws = new WebSocket 'ws://localhost:6437'

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
      time.info file
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
    print "Timing info for #{file}:"
    time.info file


serve = (page) ->
  ns = require 'node-static'
  file = new ns.Server path.dirname page
  server = require('http').createServer (req, res) ->
    req.addListener('end', -> file.serve(req, res)).resume()
  server.listen 8080, -> (setTimeout (-> server.close()), 5000)
  open "http://localhost:8080/#{path.basename page}"


run = ->
  '''
  Run as a command-line script.
    
  '''
  argv = require('optimist')
    .alias('t', 'time')
    .alias('a', 'audio')
    .alias('v', 'view')
    .boolean(['a', 'v'])
    .describe('t', 'Time in seconds to record')
    .describe('a', 'Record and save audio track')
    .describe('v', 'View recorded sample in a web browser')
    .argv

  fps = 90  # frames per second estimate
  secs = 5  # default delay time

  handsFile = 'sample.json'
  audioFile = 'sample.mov'
  viewFile = 'sample.html'

  if argv._
    file = argv._[0]
    handsFile = file + '.json'
    audioFile = file + '.mov'
    viewFile  = file + '.html'

  if argv.time
    secs = argv.time
    frames = secs * fps
    if argv.audio
      audio.record secs, audioFile
    save frames, handsFile
  else
    view file

  if argv.view  # create web page for viewing the resulting sample
    data = 
      file:
        leap: path.basename handsFile
        audio: path.basename audioFile
      script:
        view: fs.readFileSync __dirname + '/../template/view.js', 'utf8'
    viewPage = minty.renderFile __dirname + '/../template/view.cst', data
    fs.writeFile viewFile, viewPage, (err) -> 
      if err
        print err 
      else
        print "Created #{viewFile} for viewing sample"
        # setTimeout (-> serve viewFile), secs * 2000


module.exports = {run, save, view}
