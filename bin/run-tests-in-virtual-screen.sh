#!/bin/bash
TAG=$1
xvfb-run --server-args="-screen 0 ${SCREEN_WIDTH}x${SCREEN_HEIGHT}x${SCREEN_COLOUR_DEPTH} -ac" robot --outputDir /opt/robotframework/reports --include $TAG /opt/robotframework/tests
