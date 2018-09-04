#!/bin/bash

rm -rf standalone
rm -rf jars

mvn -f ../mh.libraryA/ clean install
mvn clean install

mkdir jars
cp target/mh.standaloneA-1.0-SNAPSHOT.jar jars
cp ../mh.libraryA/target/mh.libraryA-1.0-SNAPSHOT.jar jars

$JAVA_HOME/bin/jlink \
--module-path $JAVA_HOME/jmods/:jars \
--add-modules moduleMhA \
--launcher launcherMh=moduleMhA/mh.standaloneA.App \
--output standalone \
--strip-debug \
--compress 2 \
--no-header-files \
--no-man-pages

du -sh standalone

standalone/bin/launcherMh