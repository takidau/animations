source montage.sh

NAME=$(basename "$0" | sed -e 's/[.]sh$//')
FRAMES=(23 40 63 80)
FRAMES=(31 68 80) # 43 @ 3 for 1x4
FRAMES=(30 42 60 87)
TILE=1x3
TILE=2x2
Montage $NAME $FRAMES $TILE




