convert "streaming-speculative-late-discarding.gif[0]" /tmp/discarding.png
convert "streaming-speculative-late.gif[0]" /tmp/accumulating.png
convert "streaming-speculative-late-retracting.gif[0]" /tmp/retracting.png
montage /tmp/{discarding,accumulating,retracting}.png -geometry +2+2 -tile 3x1 accumulating-mode-montage-3x1.png
