handy
=====

Our nascent experiments with the [Leap](http://leapmotion.com).

We're utilizing the device's websocket stream and [Javascript API](https://github.com/leapmotion/leapjs).

Largely inspired by @syntagmatic's [leap-play](https://github.com/syntagmatic/leap-play).


## Resources

* [Leap JS API Tutorial](https://developer.leapmotion.com/documentation/guide/Sample_JavaScript_Tutorial)

* [Leap API](https://developer.leapmotion.com/documentation/api/annotated)

* [D3 API](https://github.com/mbostock/d3/wiki/API-Reference)


## Projected pieces

- [x] Recorder - record, view, and save samples.

- [x] Viewer - view saved samples in various formats.

- [ ] Editor - crop saved samples by specifying start and stop points.

- [ ] Gallery - view a collection of saved samples.

- [ ] Storage - persist samples for viewing/editing.

See `record` and `view` for working prototypes of the first two.

`bin/rec.coffee` provides a simple CLI for streaming Leap samples to disk.
