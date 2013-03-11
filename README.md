MacRuby-Timelapse
=================

MacRuby hack to take an iSight photo every 10s.

The iSight capture code was copied from Watson1978's [[gist|https://gist.github.com/Watson1978/635013/]].  I was starting to try to make it more Ruby-like than Cocoa, but I just wanted to start building my LEGO, so this got the job done.

This assumes there is a directory called `output` under the current directory and outputs files named like `YYYY-MM-DDTHH-MM-SS.jpg` (since HFS+ doesn't allow ":" in file names).

To run, just type:
`./time_lapse.rb`
