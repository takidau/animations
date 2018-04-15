#!/bin/bash
# Renders motivation.tex to motivation.gif.
# Intermediate files are named /tmp/motivation_*

outer=1             # Set outer loop counter.

for a in 0 1 2 
do
  for b in `seq 0 9`
  do
    cat motivation.tex | sed s=TO_REPLACE=${a}.${b}=g > /tmp/motivation_${a}.${b}.tex
    pdflatex --output-directory=/tmp/ /tmp/motivation_${a}.${b}.tex
    sips -s format png /tmp/motivation_${a}.${b}.pdf --out /tmp/motivation_${a}.${b}.png
  done
done               

convert -loop 0 \
	/tmp/motivation_0.0.png /tmp/motivation_0.1.png /tmp/motivation_0.2.png /tmp/motivation_0.3.png /tmp/motivation_0.4.png /tmp/motivation_0.5.png \
	/tmp/motivation_0.6.png /tmp/motivation_0.7.png /tmp/motivation_0.8.png /tmp/motivation_0.9.png /tmp/motivation_1.0.png /tmp/motivation_1.1.png \
	/tmp/motivation_1.2.png /tmp/motivation_1.3.png /tmp/motivation_1.4.png /tmp/motivation_1.5.png /tmp/motivation_1.6.png /tmp/motivation_1.7.png \
	/tmp/motivation_1.8.png /tmp/motivation_1.9.png /tmp/motivation_2.0.png /tmp/motivation_2.1.png /tmp/motivation_2.2.png /tmp/motivation_2.3.png \
   motivation.gif
	# /tmp/motivation_2.4.png /tmp/motivation_2.5.png /tmp/motivation_2.6.png /tmp/motivation_2.7.png /tmp/motivation_2.8.png /tmp/motivation_2.9.png \

exit 0
