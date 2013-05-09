#!/usr/bin/env coffee 
###
rec - save a set of JSON samples emitted from the Leap's websocket stream.

USAGE

  rec.coffee 1000 > hand.data

###
WebSocket = require 'ws'
ws = new WebSocket 'ws://localhost:6437'
fs = require 'fs'

max = parseInt process.argv[2]
max ?= 100

file = process.argv[3]
out = if file then fs.createWriteStream(file) else process.stdout 

print = console.log
i = 0   # samples seen

ws.on 'open', -> 
  print ' leap socket opened' if file
  ws.send JSON.stringify {enableGestures: true}
  out.write '[\n'

ws.on 'close', (code, reason) -> 
  out.write ']\n'
  if file
    print ' leap socket closed'
    print " #{ws.bytesReceived} bytes received"
    print " #{max} samples written to #{file}"
    print reason if reason

ws.on 'error', (err) -> print err

ws.on 'message', (d) -> 
  if i == 0
    print " version #{JSON.parse(d).version}"   # do not include version info
  else if max > i
    out.write "#{d},\n"                         # include trailing comma
  else if max == i
    out.write "#{d}\n"                          # exclude trailing comma
  else
    ws.close()
  i += 1                                        # increment sample count
