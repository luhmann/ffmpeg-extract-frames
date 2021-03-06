#!/bin/bash

SOURCE=$1
START=$2
DURATION=$3
SIZE=$4
FPS=${5-12}

TIMESTAMP=$(date +%s)
TMPDIR=tmp/$TIMESTAMP
OUTPUTDIR=output/gif/$SOURCE

#create output directory
mkdir -p $OUTPUTDIR

#create temp-dir
mkdir -p $TMPDIR

echo "Extracting Images .."

#extract images
if [ -n "$SIZE" ]; then
	ffmpeg -i $SOURCE -ss $START -t $DURATION -s $SIZE -f image2 -vf fps=fps=$FPS $TMPDIR/$SOURCE-img%03d.jpg
else
	ffmpeg -i $SOURCE -ss $START -t $DURATION -f image2 -vf fps=fps=$FPS $TMPDIR/$SOURCE-img%03d.jpg
fi

echo "Combining images ..."

#combine all images into a sprite
convert -fuzz 1% -verbose -delay 1x10 $TMPDIR/*.jpg -coalesce -layers OptimizeTransparency $OUTPUTDIR/$TIMESTAMP-$SOURCE.gif

#delete tmp-dir
rm -R $TMPDIR 
