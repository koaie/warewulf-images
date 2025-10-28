#!/bin/sh

file=$1
dest=$2
registry=$3
uri=$4

set -e

build_path=/tmp/warewulf/build
mkdir -p $build_path


skopeo login $3
apptainer build --sandbox $buildpath/$dest $file 
tar cvf $build_path/$dest.tar build_path/$dest/*
skopeo copy tarball:$build_path/$dest.tar docker://$registry/$uri
rm -rf "/tmp/warewulf/build"

