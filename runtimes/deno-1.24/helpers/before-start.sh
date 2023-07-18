#!/bin/sh
# Fail build if any command fails
set -e

echo "Preparing for start ..."

# Extract gzipped code from mounted volume to function folder
tar -zxf /mnt/code/code.tar.gz -C /usr/local/server/src/function

# Load Deno cache from build step
export DENO_DIR="/usr/local/server/src/function/deno-cache"

# Apply env vars from build step
set -o allexport
source /usr/local/server/src/function/.open-runtimes
set +o allexport

# Enter server folder
cd /usr/local/server

echo 'Starting ...'