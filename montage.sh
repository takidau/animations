function Montage() {
    NAME=$1
    FRAMES=$2
    TILE=$3
    CMD="montage"

    echo "NAME   : $NAME"
    echo "FRAMES : ${FRAMES[@]}"
    echo "TILE   : $TILE"
    
    for i in ${FRAMES[@]}
    do
	OUT="/tmp/$NAME-$i.png"
	echo "Extracting $OUT..."
	convert "$NAME.gif[$i]" $OUT
	CMD="$CMD $OUT"
    done
    CMD="$CMD -geometry +2+2 -tile $TILE $NAME-montage-$TILE.png"
    echo $CMD
    $($CMD)
}

