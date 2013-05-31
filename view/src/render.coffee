$ = (id) -> document.getElementById id

paused = false

render = (err, data) ->
  if err
    alert err.statusText 
  else
    window.data = data
    last = data.length - 1
    i = 0
    duration = (data[last].timestamp - data[0].timestamp) / 1000
    step = duration / data.length

    canvas = $('viz')
    canvas.width = 800
    canvas.height = 800
    ctx = canvas.getContext("2d")
    x = d3.scale.linear()
      .range([0, canvas.width])
      .domain([-200, 200])
    y = d3.scale.linear()
      .range([canvas.height, 0])
      .domain([0, 400])

    renderPointables = (frame) ->
      ctx.fillStyle = "rgba(245, 245, 245, 0.3)"
      ctx.fillRect 0, 0, canvas.width, canvas.height
      ctx.fillStyle = "#555"
      if frame.pointables?
        for p in frame.pointables
          pos = p.tipPosition
          ctx.fillRect x(pos[0]), y(pos[1]), 14, 14

    renderInfo = (frame) -> 
      info.innerHTML = frame.timestamp

    idle = ->
      if paused then setTimeout(idle, step) else run() 

    run = () ->
      if paused
        setTimeout(run, step)
      else
        i = 0 if i is last
        frame = data[i]
        renderPointables(frame)
        renderInfo(frame)
        i++
        setTimeout(run, step)

    run()


window.pause = ->
  paused = not paused


window.load = (file) -> d3.json file, render
