#!/bin/bash

SOURCE=$1
START=$2
DURATION=$3
SIZE=$4
FPS=$5

TIMESTAMP=$(date +%s)
OUTPUTDIR=output/video/$SOURCE

#create output-dir
mkdir -p $OUTPUTDIR

#Encode webm
if [ -n "$SIZE" ]; then
	ffmpeg -i $SOURCE -ss $START -t $DURATION -an -s $SIZE -aq 5 -ac 2 -qmax 25 -threads 2 -r $FPS $OUTPUTDIR/$SOURCE-$TIMESTAMP.webm
else
	ffmpeg -i $SOURCE -ss $START -t $DURATION -an -aq 5 -ac 2 -qmax 25 -threads 2 -r $FPS $OUTPUTDIR/$SOURCE-$TIMESTAMP.webm
fi

#Encode mp4
if [ -n "$SIZE" ]; then
	ffmpeg -i $SOURCE -ss $START -t $DURATION -s $SIZE -r $FPS -codec:v libx264 -profile:v high -preset slow -b:v 500k -maxrate 500k -bufsize 1000k -threads 0 -an $OUTPUTDIR/$SOURCE-$TIMESTAMP.mp4
#	ffmpeg -i $SOURCE -ss $START -t $DURATION -an -s $SIZE -aq 5 -ac 2 -qmax 25 -threads 2 -r $FPS $OUTPUTDIR/$SOURCE-$TIMESTAMP.mp4
else
	ffmpeg -i $SOURCE -ss $START -t $DURATION -r $FPS -codec:v libx264 -profile:v high -preset slow -b:v 500k -maxrate 500k -bufsize 1000k -threads 0 -an $OUTPUTDIR/$SOURCE-$TIMESTAMP.mp4
#	ffmpeg -i $SOURCE -ss $START -t $DURATION -an -aq 5 -ac 2 -qmax 25 -threads 2 -r $FPS $OUTPUTDIR/$SOURCE-$TIMESTAMP.mp4
fi
