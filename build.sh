#!/bin/sh

file=$1
dest=$2
registry=$3
uri=$4
skopeo login $3
apptainer build --sandbox $dest $file 
tar cvf $dest.tar $dest/*
skopeo copy tarball:$dest.tar docker://$registry/$uri
