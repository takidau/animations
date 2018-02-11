source montage.sh

NAME=$(basename "$0" | sed -e 's/[.]sh$//')
FRAMES=(38 60 77 94)
TILE=2x2
Montage $NAME $FRAMES $TILE




