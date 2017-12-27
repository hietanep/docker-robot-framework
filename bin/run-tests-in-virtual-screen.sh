#!/bin/bash
# first argument is used as TAG to define witch test are run
TAG=$1

if [ "$TAG" == "" ]
then
xvfb-run --server-args="-screen 0 ${SCREEN_WIDTH}x${SCREEN_HEIGHT}x${SCREEN_COLOUR_DEPTH} -ac" robot --outputDir /opt/robotframework/reports /opt/robotframework/tests
else
xvfb-run --server-args="-screen 0 ${SCREEN_WIDTH}x${SCREEN_HEIGHT}x${SCREEN_COLOUR_DEPTH} -ac" robot --outputDir /opt/robotframework/reports --include $TAG /opt/robotframework/tests
fi