source montage.sh

NAME=$(basename "$0" | sed -e 's/[.]sh$//')
FRAMES=(45 66 82 98)
TILE=2x2
Montage $NAME $FRAMES $TILE




