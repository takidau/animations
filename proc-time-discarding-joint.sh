source montage.sh

NAME=$(basename "$0" | sed -e 's/[.]sh$//')
FRAMES=(11 27 0) # 43 @ 3 for 1x4
Montage $NAME $FRAMES "1x3"




