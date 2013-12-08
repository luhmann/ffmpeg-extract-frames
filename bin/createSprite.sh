#!/bin/bash

SOURCE=$1
START=$2
DURATION=$3
SIZE=$4
FPS=${5-12}

TIMESTAMP=$(date +%s)
TMPDIR=tmp/$TIMESTAMP
OUTPUTDIR=output/sprites/$TIMESTAMP-$SOURCE

#create output directory
mkdir -p $OUTPUTDIR 

#create temp-dir
mkdir -p $TMPDIR 

#extract images from -ss timestamp at duration -t, -s scale to size
if [ -n "$SIZE" ]; then
	ffmpeg -i $SOURCE -ss $START -t $DURATION -s $SIZE -f image2 -vf fps=fps=$FPS $TMPDIR/$SOURCE-img%03d.jpg
else
	ffmpeg -i $SOURCE -ss $START -t $DURATION -f image2 -vf fps=fps=$FPS $TMPDIR/$SOURCE-img%03d.jpg
fi
#convert to sprite map with imagemagick
convert $TMPDIR/*.jpg -verbose -append $OUTPUTDIR/$SOURCE-$TIMESTAMP.jpg

#delete temp-dir
rm -R $TMPDIR 
