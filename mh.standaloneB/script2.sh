#!/bin/bash

rm -rf standalone

mvn clean install

cp target/mh.standaloneB-1.0-SNAPSHOT.jar jars

$JAVA_HOME/bin/jlink \
--module-path $JAVA_HOME/jmods/:jars \
--add-modules moduleMhB \
--launcher launcherMh=moduleMhB/mh.standaloneB.App \
--output standalone \
--strip-debug \
--compress 2 \
--no-header-files \
--no-man-pages

du -sh standalone

standalone/bin/launcherMh