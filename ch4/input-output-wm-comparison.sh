#!/bin/bash
set -x
convert "input-output-wm-sessions.gif[48]" /tmp/io1.png
convert "input-output-wm-sessions-output-ts.gif[48]" /tmp/io2.png
montage /tmp/io1.png /tmp/io2.png -geometry +2+2 -tile 2x1 input-output-wm-comparison-montage-2x1.png





