source ../montage.sh


NAME=$(basename "$0" | sed -e 's/[.]sh$//')
FRAMES=(11 27 48)
Montage $NAME $FRAMES "1x3"




