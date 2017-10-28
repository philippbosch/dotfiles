#!/bin/bash

set -e

DOTFILESDIR=$(readlink -f $(dirname $0))
FIND=$(command -v gfind || echo 'find')
DIRS=$($FIND $DOTFILESDIR -mindepth 1 -path $DOTFILESDIR/.git -prune -o -type d -printf '%P\n')
FILES=$($FIND $DOTFILESDIR -mindepth 1 -path $DOTFILESDIR/.git -prune -o -type f,l -not -name $(basename $0) -not -name README.md -printf '%P\n')

for DIR in $DIRS ; do
  echo "› Creating directory $DIR"
  if [ -d $DIR ] ; then
    echo "  Directory exists."
  else
    mkdir -p $DIR
  fi
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


