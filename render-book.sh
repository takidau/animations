#!/bin/bash

DENSITY=500
DELAY=15
XTRIM=50
YTRIM=50

function render_gif() {
    NAME=$1
    time convert -density $DENSITY -delay $DELAY -loop 0 $NAME.pdf $NAME.gif
}

function render_mp4() {
    NAME=$1
    time ffmpeg -y -i $NAME.gif -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw*1080/ih/2)*2:1080" $NAME.mp4
}

function render_montage() {
    # The montage scripts are written to be run from the directory
    # they reside in, so change working directory then change back
    # when done.
    DIR=$(dirname $1)
    BASE=$(basename $1)
    CWD=$(pwd)
    cd $DIR
    echo "DIR=$(pwd)"
    ./$BASE.sh
    cd $CWD
    echo "DIR=$(pwd)"
}

function copy() {
    NAME=$1
    FIG=$2
    cp -v $NAME.gif book/stsy_$FIG.gif
    cp -v $NAME.mp4 book/stsy_$FIG.mp4
    TILE=$(ls $NAME-montage-?x?.png | sed -e 's~.*\([0-9]x[0-9]\)\.png~\1~')
    IMON="$NAME-montage-$TILE.png"
    cp -v $IMON book/stsy_$FIG.png
    split_montage $IMON $TILE
    for f in book/stsy_$FIG*.png
    do
	trim $f
    done
}   

function split_montage() {
    IMON=$1
    TILE=$2
    IW=$(convert $IMON -format "%W" info:)
    IH=$(convert $IMON -format "%H" info:)
    ROWS=$(echo "$TILE" | sed -e 's/[0-9]*x\([0-9]*\)/\1/')
    OW=$IW
    OH=$(echo "$IH/$ROWS" | bc)
    echo "TILE=$TILE"
    #echo "ROWS=$ROWS"
    #echo "IW=$IW"
    #echo "IH=$IH"
    #echo "OW=$OW"
    #echo "OH=$OH"
    for i in $(seq 1 $ROWS)
    do
	#echo "i=$i"
	YOFF=$(echo "($i-1) * $OH" | bc)
	#echo "- YOFF=$YOFF"
	CMD="convert $IMON -crop ${OW}x${OH}+0+${YOFF} +repage book/stsy_${FIG}x${i}.png"
	echo "$CMD"
	$($CMD)
    done
}

function trim() {
    FILE=$1
    IW=$(convert $FILE -format "%W" info:)
    IH=$(convert $FILE -format "%H" info:)
    OW=$(echo "$IW-$XTRIM*2" | bc)
    OH=$(echo "$IH-$YTRIM*2" | bc)
    #echo "IW=$IW"
    #echo "IH=$IH"
    #echo "OW=$OW"
    #echo "OH=$OH"
    CMD="convert $FILE -crop ${OW}x${OH}+${XTRIM}+${YTRIM} +repage $FILE"
    echo $CMD
    $($CMD)
}

function do_render() {
    NAME=$1
    FIG=$2
    echo "----------------------------------------"
    echo "$NAME → $FIG"
    echo "----------------------------------------"
    render_gif $NAME
    render_mp4 $NAME
    render_montage $NAME
}

function render() {
    NAME=$1
    FIG=$2
    echo "$NAME → $FIG"
    do_render $NAME $FIG &> $NAME.render.log
    copy $NAME $FIG $TILE
}

function render_thread1() {
    #render batch-fixed 0205
    #render streaming-per-record 0206
    #render streaming-2min-aligned 0207
    #render streaming-2min-delay 0208
    XTRIM=100
    #render streaming-wm-joint 0210
    render streaming-speculative-late-joint 0211
    XTRIM=10
    YTRIM=10
    #render ch3/input-output-wm-sessions 0305
    #render ch3/motivation 0301
    XTRIM=50
    YTRIM=50
    echo "Thread #1 done"
}

function render_thread2() {
    #render classic-batch 0203
    #render streaming-speculative-late-allowed-lateness-1min 0212
    #render streaming-speculative-late-discarding 0213
    #render streaming-speculative-late-retracting 0214
    XTRIM=100
    #render streaming-wm-joint 0302
    XTRIM=10
    YTRIM=10
    #render ch3/input-output-wm-input-only 0304
    XTRIM=50
    YTRIM=50
    echo "Thread #2 done"
}

function render_thread3() {
    XTRIM=10
    YTRIM=10
    #render ch3/input-output-wm-sessions-output-ts 0306
    XTRIM=50
    XTRIM=50
    #render streaming-wm-percentile 0310
    DELAY=7
    #render input-toggle 0401
    DELAY=15
    XTRIM=100
    #render streaming-speculative-late-toggle-joint 0402
    #render proc-time-discarding-joint 0403
    #render ingress-time-joint 0404
    XTRIM=50
    echo "Thread #3 done"
}

function render_thread4() {
    #render sessions-boxed 0407
    XTRIM=10
    YTRIM=10
    #render window-alignment-aligned 0408
    #render window-alignment-unaligned 0409
    #render window-sizes 0410
    XTRIM=50
    YTRIM=50
    #render sessions-bounded 0411
    #render streams-tables-classic-batch 0604
    #render streams-tables-batch-fixed 0606
    #render streams-tables-streaming-per-record 0608
    echo "Thread #4 done"
}

function render_thread5() {
    #render streaming-wm 0609
    #render streams-tables-streaming-wm 0610
    #render streaming-speculative-late 0611
    #render streams-tables-streaming-speculative-late 0612
    XTRIM=30
    #render streams-tables-gbk 0701
    XTRIM=50
    #render streams-tables-streaming-wm-late 0811
    echo "Thead #5 done"
}

function render_thread6() {
    #render streams-tables-streaming-1min 0812
    #render streams-tables-sql-validity-windows 0901
    XTRIM=30
    #render streams-tables-streaming-sessions-no-retractions 0813
    #render streams-tables-streaming-sessions 0814
    #render streams-tables-sql-temporal-join 0902
    #render streams-tables-sql-temporal-join-wm 0903
    XTRIM=50
    echo "Thead #6 done"
}

mkdir -p book
render_thread1 &
render_thread2 &
render_thread3 &
render_thread4 &
render_thread5 &
render_thread6 &
wait
exit
echo
copy classic-batch 0603
copy batch-fixed 0605
copy streaming-per-record 0607
copy streams-tables-streaming-speculative-late 0702
copy streams-tables-classic-batch 0807
copy streams-tables-batch-fixed 0808
copy streams-tables-streaming-per-record 0809
copy streams-tables-streaming-wm 0810
