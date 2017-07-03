LaTeX/Tikz animation goodness.

Overview:
---------
Each diagram corresponds to a single main LaTeX file, e.g. the sessions
diagram corresponds to sessions.tex. All of the diagrams depend on a
common library of commands definitions and initialization in the
diagrams.tex file.

Each frame of animation advances processing time by 1/9 of a minute
(i.e. 0.111). I don't remember why I set it up this way originally, 
I just did, and it's worked out pretty well.

The main command used to render a single frame is \TriggersDiagram.
It takes two parameters*:
 1. The processing time for the frame.
 2. The Tikz commands used to draw any state, output, etc
    primitives on the screen.

*Technically it takes three parameters. The truly first parameter
is the color of the horizontal line indicating what time it is in
processing time, for fading that line out. This is typically only
used for the final frames of the animation.

Most of the rendering is done using other custom commands for basic
primitives, like \DrawState and \DrawOutput. Poking around in the
existing files and the command definitions should be pretty helpful
for figuring them all out. 



Setup (Mac - RECOMMENDED):
--------------------------

1. Install MacTex package:
     Direct link: http://mirror.ctan.org/systems/mac/mactex/MacTeX.pkg
     TexShop page: http://pages.uoregon.edu/koch/texshop/obtaining.html
2. Install MacPorts: https://www.macports.org/install.php
3. Install ImageMagick: see http://www.imagemagick.org/script/binary-releases.php
     sudo port install ImageMagick



Setup (Linux Workstation):
--------------------------

NOTE: I never fully managed to get fonts working properly on Linux.
You'll either have to figure out how to make that work, or comment
out the FiraSans lines in diagrams.tex to get this to render on your
workstation. Or just use a Mac, as above.

Some subset of the following commands are needed to install the
necessary LaTeX packages (I'm not sure which, since I was totally
shooting in the dark trying to get this set up the first time, and
I know of no good way to return to a clean state to try it all over
again from the beginning):

```
tlmgr init-usertree
tlmgr update --self
tlmgr install texgreek cbfonts cbfonts-fd tlmgr install greek-fontenc fira
```

You'll also need the pdflatex and convert (i.e. Image Magick) commands installed. For me, they already were (not sure if I installed them manually once upon a time, or not).



LaTeX to PDF:
-------------

Mac: Open file in TexShop, Render to PDF (command+t).

Linux: `pdflatex sessions.tex`



PDF to GIF:
-----------

```
# High-resolution
NAME=sessions && time convert -density 300 -delay 15 -loop 0 $NAME.pdf $NAME.gif

# Low-resolution
NAME=sessions && time convert -density 150 -delay 15 -loop 0 $NAME.pdf $NAME.gif
```


Extract frames from GIF to PNG:
-------------------------------

```
# First frame
NAME=sessions && convert "$NAME.gif[0]" $NAME-first.png

# Last frame
NAME=sessions && convert "$NAME.gif[-1]" $NAME-final.png
```