applescript = require 'applescript'
exec = require('child_process').exec
print = console.log 

move = (source, target, err_handler) ->
  exec "mv #{source} #{target}", (err) -> err_handler err

record = (secs=5, file) ->

  script = """
    tell application "QuickTime Player"
      activate
      close every window saving no
      set audioRecording to (new audio recording)
      tell audioRecording
        start
        delay #{secs}
        stop
      end tell
      save
      close every window saving no
    end tell
    """

  applescript.execString script, (err, r) ->
    if err 
      print "error!" 
    else 
      print r if r
      move '~/Movies/Audio*Recording.mov', file, (err) ->
        if err
          print err
        else
          print "Created #{file} with #{secs} seconds of audio!"

run = ->
  '''
  Run as a command-line script.
    
  '''
  argv = require('optimist')
          .alias('t', 'time')
          .default('t', 5)
          .describe('t', 'Time in seconds to record')
          .argv

  file = argv._[0]
  target = if file? then file + ".mov" else __dirname + "/audio.mov"
  record argv.time, target

module.exports = {run, record}
