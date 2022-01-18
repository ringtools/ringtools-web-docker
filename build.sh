#!/bin/sh

git submodule update --recursive --remote
docker build -t ringtools/web .