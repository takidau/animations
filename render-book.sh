#!/bin/bash

DENSITY=500

function render_gif() {
    NAME=$1
    time convert -density $DENSITY -delay 15 -loop 0 $NAME.pdf $NAME.gif
}

function render_mp4() {
    NAME=$1
    time ffmpeg -y -i $NAME.gif -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw*1080/ih/2)*2:1080" $NAME.mp4
}

function render_montage() {
    NAME=$1
    ./$NAME.sh
}

function copy() {
    NAME=$1
    FIG=$2
    cp -v $NAME.gif book/stsy_$FIG.gif
    cp -v $NAME.mp4 book/stsy_$FIG.mp4
    cp -v $NAME-montage.png book/stsy_$FIG.png
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
    copy $NAME $FIG
}

function render_thread1() {
    render classic-batch 0203
    render batch-fixed 0205
    render streaming-per-record 0206
    render streaming-2min-aligned 0207
    render streaming-2min-delay 0208
    render streaming-wm-joint 0210
    render streaming-speculative-late-joint 0211
    echo "Thread #1 done"
}

function render_thread2() {
    render streaming-speculative-late-allowed-lateness-1min 0212
    render streaming-speculative-late-discarding 0213
    render streaming-speculative-late-retracting 0214
    render streaming-wm-joint 0302
    render ch3/input-output-wm-input-only 0304
    render ch3/input-output-wm-sessions 0305
    echo "Thread #2 done"
}

function render_thread3() {
    render ch3/input-output-wm-sessions-output-ts 0306
    render streaming-wm-percentile 0310
    render input-toggle 0401
    render streaming-speculative-late-toggle-joint 0402
    render proc-time-discarding-joint 0403
    render ingress-time-joint 0404
    echo "Thread #3 done"
}

function render_thread4() {
    render sessions-boxed 0407
    render window-alignment-aligned 0408
    render window-alignment-unaligned 0409
    render sessions-bounded 0410
    render streams-tables-classic-batch 0604
    render streams-tables-batch-fixed 0606
    render streams-tables-streaming-per-record 0608
    echo "Thread #4 done"
}

function render_thread5() {
    render streaming-wm 0609
    render streams-tables-streaming-wm 0610
    render streaming-speculative-late 0611
    render streams-tables-streaming-speculative-late 0612
    render streams-tables-gbk 0701
    render streams-tables-streaming-wm-late 0811
    echo "Thead #5 done"
}

function render_thread6() {
    render streams-tables-streaming-1min 0812
    render streams-tables-streaming-sessions-no-retractions 0813
    render streams-tables-streaming-sessions 0814
    render streams-tables-sql-validity-windows 0901
    render streams-tables-sql-temporal-join 0902
    render streams-tables-sql-temporal-join-wm 0903
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

echo
copy classic-batch 0603 #
copy batch-fixed 0605 #
copy streaming-per-record 0607 #
copy streams-tables-streaming-speculative-late 0702 #
copy streams-tables-classic-batch 0807 #
copy streams-tables-batch-fixed 0808 #
copy streams-tables-streaming-per-record 0809 #
copy streams-tables-streaming-wm 0810 #
