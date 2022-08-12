#!/bin/bash
dir_name=zipik
if [ -f "$dir_name.zip" ]
then
  echo "zip $dir_name exists"
else
  if [ -b "$dir_name" ]
  then
    echo "dir $dir_name exists"
  else
    mkdir $dir_name
    echo "dir $dir_name created"
    for i;
    do
      echo $i
      cp $i $dir_name/$i
    done
    zip -r $dir_name.zip $dir_name
    rm -r $dir_name
  fi
fi
