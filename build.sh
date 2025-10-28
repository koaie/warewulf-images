#!/bin/sh

dest=$1
registry=$2
uri=$3

set -e

build_path=/tmp/warewulf/build
mkdir -p $build_path


skopeo login $registry
apptainer build --sandbox $build_path/$dest $dest.def 
tar cvf $build_path/$dest.tar $build_path/$dest/*
skopeo copy tarball:$build_path/$dest.tar docker://$registry/$uri
rm -rf "/tmp/warewulf/build"

