source montage.sh

NAME=$(basename "$0" | sed -e 's/[.]sh$//')
FRAMES=(40 58 73 82)
TILE=2x2
Montage $NAME $FRAMES $TILE




