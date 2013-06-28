$ = (id) -> document.getElementById id

sample = ''
paused = false  # pause/play status
done = false    # finished playing sample?
i = 0           # index of current frame

render = (err, data) ->
  if err
    alert err.statusText 
  else
    window.data = data
    last = data.length - 1
    duration = (data[last].timestamp - data[0].timestamp) / 1000
    step = duration / data.length

    canvas = $('viz')
    canvas.width = 500
    canvas.height = 500
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
          ctx.fillRect x(pos[0]), y(pos[1]), 20, 20 
      ctx.fillStyle = "#777"
      if frame.hands?
        for h in frame.hands
          pos = h.palmPosition
          ctx.fillRect x(pos[0]), y(pos[1]), 40, 40 
          ctx.fillStyle = "steelblue"
          ctx.fillRect 10, y(pos[1]), 40, 40 

    renderInfo = (frame) -> 
      stamp.innerHTML = frame.timestamp
      hands.innerHTML = JSON.stringify frame.hands?[0]?.palmPosition[1]

    run = () ->
      frame = data[i]
      renderPointables(frame)
      renderInfo(frame)
      if i == last
        done = true
        $('play').textContent = '⊕'
      else
        i++
        setTimeout(run, step)

    run()

window.play = ->
  if done
    done = false
    i = 0   # reset frame index
    $('play').textContent = '⊗'
    audio = $('audio')
    audio.load() if window.chrome
    audio.play()
    $('audio').play()
    d3.json sample, render

window.back = ->
  i = if i > 0 then i - 30 else 0

window.skip = ->
  i = if (i + 30) < last then i + 30 else 0

window.load = (file) -> 
  sample = file
  d3.json sample, render
