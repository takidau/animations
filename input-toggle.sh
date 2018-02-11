source montage.sh

NAME=$(basename "$0" | sed -e 's/[.]sh$//')
FRAMES=(50 0)
Montage $NAME $FRAMES "2x1"




