source montage.sh

NAME=$(basename "$0" | sed -e 's/[.]sh$//')
FRAMES=(30 42 63 80)
TILE=2x2
Montage $NAME $FRAMES $TILE




