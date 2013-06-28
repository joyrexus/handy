exec = require('child_process').exec
print = console.log

move = (source, target, err_handler=print) ->
  exec "mv #{source} #{target}", (err) -> err_handler err

open = (file, err_handler=print) ->
  exec "open #{file}", (err) -> err_handler err

module.exports = {move, open}

