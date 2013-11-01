# Handy

Provides a simple CLI for recording and viewing a gesture sample with the [Leap](http://leapmotion.com) device.  It enables you to capture a gesture sample (with optional audio) and generate a web page with the sample embedded.  

The following would create a 10 second gesture sample (`SAMPLE.json`) along with accompanying audio file (`SAMPLE.mov`) and web page for viewing/listening to both (`SAMPLE.html`):

  handy --time 10 --audio --view SAMPLE


# Notes

**Handy** utilizes the Leap's [websocket stream](https://gist.github.com/joyrexus/7217032).  

This [gist](https://gist.github.com/joyrexus/5555728) demonstrates how to connect to the device's websocket server.  (Like **Handy**, it pipes a user specified number of frames from the websocket stream to `stdout` or to a user specified filename.)

See our [notes](https://github.com/joyrexus/notes/blob/master/leap/index.md) for an overview of the device, links to related projects, and useful development references.

We're currently developing [custom rendering tools](https://github.com/joyrexus/leap) (deployed [here](http://joyrexus.github.io/sandbox/leap/viewer/)) to visualize particular aspects of the gesture samples we're capturing.
