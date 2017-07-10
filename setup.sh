#!/bin/bash

#set -e

DOTFILESDIR=$(dirname $0)
DIRS=$(find $DOTFILESDIR -mindepth 1 -path $DOTFILESDIR/.git -prune -o -type d -printf '%P\n')
FILES=$(find $DOTFILESDIR -mindepth 1 -path $DOTFILESDIR/.git -prune -o -type f -not -name $(basename $0) -printf '%P\n')

for DIR in $DIRS ; do
  echo "› Creating directory $DIR"
  mkdir -p $DIR
done

for FILE in $FILES ; do
  echo "› Linking $FILE"
  LINKTARGET=$DOTFILESDIR/$FILE
  if [ -L $FILE ] ; then
    CURRENTLINKTARGET=$(readlink $FILE)
    if [ $CURRENTLINKTARGET = $LINKTARGET ] ; then
      echo "  Symlink already set up. Skipping."
    else
      echo "  Symlink exists but points to $CURRENTLINKTARGET instead of $LINKTARGET. Skipping."
    fi
    continue
  fi

  if [ -e $FILE ] ; then
    echo "  File exists! Skipping."
    continue
  fi
  ln -s $DOTFILESDIR/$FILE $FILE
done


