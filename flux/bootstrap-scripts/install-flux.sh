#!/usr/bin/env sh

 set -e

 flux check --pre

 flux bootstrap github \
   --owner=$GITHUB_USER \
   --repository=graylog-hello \
   --branch=main \
   --path=./flux/cluster/graylog-eks \
   --personal
