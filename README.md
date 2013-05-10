handy
=====

Our nascent experiments with the [Leap](http://leapmotion.com).

We're utilizing the device's websocket stream and [Javascript API](https://github.com/leapmotion/leapjs).

Largely inspired by [@syntagmatic](https://github.com/syntagmatic)'s [leap-play](https://github.com/syntagmatic/leap-play) and [prehensile](https://github.com/syntagmatic/prehensile).


## Resources

* [Open Leap Forum](https://github.com/openleap)

* [Leap JS API Tutorial](https://developer.leapmotion.com/documentation/guide/Sample_JavaScript_Tutorial)

* [Leap API](https://developer.leapmotion.com/documentation/api/annotated)

* [D3 API](https://github.com/mbostock/d3/wiki/API-Reference)


## Projected pieces

- `Recorder` - record a sample (set of frames).

- `Viewer` - view saved samples in various formats.

- `Editor` - edit saved samples (e.g., crop by specifying start and stop points).

- `Gallery` - view a collection of saved samples.

- `Storage` - persist samples for viewing/editing.

See `record` and `view` for working prototypes of the first two.

`bin/rec.coffee` provides a simple CLI for saving a gesture sample.  It pipes a
user specified number of frames from the Leap's websocket stream to `stdout` or to a
user specified filename.
