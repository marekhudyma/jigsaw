#!/usr/bin/env bash

rm -rf standalone
rm -rf jars
mkdir jars

mvn clean install

cp mh.standalone/target/mh.standalone-1.0-SNAPSHOT.jar jars
cp mh.library/target/mh.library-1.0-SNAPSHOT.jar jars

$JAVA_HOME/bin/jlink \
--module-path $JAVA_HOME/jmods/:jars \
--add-modules moduleMh \
--launcher launcherMh=moduleMh/mh.standalone.App \
--output standalone \
--strip-debug \
--compress 2 \
--no-header-files \
--no-man-pages

du -sh standalone
