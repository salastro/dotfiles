# Scripts
Here is some scripts that I use daily
## System
scripts that is related to system utilities
### camera
simple script that takes available cameras then outputs them in dmenu and open it in mpv with special arguments.
### volume
simple script to control system's volume.
### power
simple script that outputs some power options (e.g. shutdown) in dmenu.
### low-cpu
simple script that controls the maximum power of **Intel** CPUs and turn off/on turbo mode.
## Keyboard
scripts related to the keyboard in a way or another.
### keys
A one-liner that opens `xev` and filter the output to show keys and their code.
### special-chars-menu
simple script to output some special characters in dmenu and then copy, or type, the selected one.
## Video recording
scripts related to recording videos (I record some [videos](https://www.youtube.com/channel/UCKFiOV9i50HOyfeNdhNvZuA)) that are not mentioned in previous sections
### record-screen
simple script to record screen with `ffmpeg`, if the recording is on, it will kill the process which will close it, this is made to be integrated with [sxhkd](https://github.com/search?q=sxhkd&type=Everything&repo=&langOverride=&start_value=1).
### xscreenkey
simple script that start screenkey if it isn't open and if it is closes it, made much like the `record-screen` script
## Other
### sent-pywal-theme
simple script to grab pywal colors and use it with sent (requires command-line options patch), the same principle can be used without the patch but will need recompiling the program.
