# hogehiko_visualizer

Midi visualizers and effects on MAX (for Live) and Processing

## Install

* Processing
  * https://processing.org/
  * oecP5 required
* MAX for Live
  * Plugins
    * m4l/osc_send.amdx
      * Encodes and sends osc midi messages to localhost:2346
    * m4l/osc_recieve.amdx
      * Receives and decodes osc midi messages from port 2347
  * Just drug and drop plugin files to your trucks.

## Sketchs

### rain_echo

* A MIDI note as a raindrop
* Landing of raindrops generate new MIDI notes with weaken velocity.
  