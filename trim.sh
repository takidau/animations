#!/bin/bash
for f in $@
do
    echo $f
    IW=$(convert $f -format "%W" info:)
    IH=$(convert $f -format "%H" info:)
    OW=$(echo "$IW-100" | bc)
    OH=$(echo "$IH-100" | bc)
    echo "IW=$IW"
    echo "IH=$IH"
    echo "OW=$OW"
    echo "OH=$OH"
    CMD="convert $f -crop ${OW}x${OH}+50+50 +repage $f"
    echo $CMD
    $($CMD)
done


