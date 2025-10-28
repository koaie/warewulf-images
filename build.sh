#!/bin/sh

file=$1
dest=$2
uri=$3
skopeo login
apptainer build --sandbox $dest $file 
tar cvf $dest.tar $dest/*
skopeo copy tarball:$dest.tar docker://$uri
