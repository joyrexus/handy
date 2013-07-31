Handy
=====

Our nascent experiments with the [Leap](http://leapmotion.com).

We're utilizing the device's websocket stream and [Javascript API](https://github.com/leapmotion/leapjs).

Largely inspired by [@syntagmatic](https://github.com/syntagmatic)'s [leap-play](https://github.com/syntagmatic/leap-play) and [prehensile](https://github.com/syntagmatic/prehensile).


## Resources

* [Leap JS](http://js.leapmotion.com/)

  * [API](https://developer.leapmotion.com/documentation/Languages/JavaScript/API/index.html)
  * [Overview](https://developer.leapmotion.com/documentation/Languages/JavaScript/Guides/Leap_Overview.html)
  * [Tutorial](https://developer.leapmotion.com/documentation/guide/Sample_JavaScript_Tutorial)
  * [Reference](http://leapmotion.github.io/leapjs/)

* [Leap API](https://developer.leapmotion.com/documentation/api/annotated)

* [D3 API](https://github.com/mbostock/d3/wiki/API-Reference)

* [Open Leap Forum](https://github.com/openleap)


## Examples

* [Demos](http://leapmotion.github.io/leapjs/examples/)

* [Gists](https://gist.github.com/leapjs)

* [Sandbox](https://github.com/joyrexus/sandbox/tree/master/leap)


## Projected pieces

- `Recorder` - record a sample (set of frames).

- `Viewer` - view saved samples in various formats.

- `Editor` - edit saved samples (e.g., crop by specifying start and stop points).

- `Gallery` - view a collection of saved samples.

- `Storage` - persist samples for viewing/editing.

See `record` and `view` for working prototypes of the first two.

`bin/rec.coffee` provides a simple CLI for saving a gesture sample: [gist](https://gist.github.com/joyrexus/5555728).  It pipes a user specified number of frames from the Leap's websocket stream to `stdout` or to a user specified filename.
