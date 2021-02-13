#!/bin/bash
set -ex
# This script is the Jenkins build helper as it were. 

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
THIS_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
echo "This Dir: $THIS_DIR"

GIT_SHA=$(git rev-parse HEAD | cut -c 1-8)

IMAGE="jeremykuhnash/gentoo-catalyst:$GIT_SHA"
LATEST_IMAGE="jeremykuhnash/gentoo-catalyst:latest"
docker build -t $IMAGE -t $LATEST_IMAGE -f $THIS_DIR/Dockerfile.gentoo .
docker push $IMAGE
docker push $LATEST_IMAGE

