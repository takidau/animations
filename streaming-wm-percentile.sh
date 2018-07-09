source montage.sh

NAME=$(basename "$0" | sed -e 's/[.]sh$//')
FRAMES=(11 27 37 0)
Montage $NAME $FRAMES "2x2"




