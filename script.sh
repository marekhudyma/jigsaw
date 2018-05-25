#!/usr/bin/env bash

rm -rf standalone
rm -rf jars

mvn clean install -U

mkdir jars
cp mh.standalone/target/mh.standalone-1.0-SNAPSHOT.jar jars
cp mh.library/target/mh.library-1.0-SNAPSHOT.jar jars


$JAVA_HOME/bin/jlink \
--module-path $JAVA_HOME/jmods/:jars \
--add-modules moduleMh,jdk.net \
--launcher launcherMh=moduleMh/mh.standalone.App \
--output standalone \
--strip-debug \
--compress 2 \
--no-header-files \
--no-man-pages

--------------- Links
https://sites.google.com/a/athaydes.com/renato-athaydes/posts/guidetojava9-compilejarrun
https://stackoverflow.com/questions/47222226/how-to-inject-module-declaration-into-jar/47222302#47222302
https://maven.apache.org/plugins/maven-jlink-plugin/

Instruction:
-> I generated library mh.library.without-1.0-SNAPSHOT.jar - in Java 8 without module-info

-> Using jdeps you can check which libraries are used by this library (results are as expected):
$ jdeps -s mh.library.without-1.0-SNAPSHOT.jar
mh.library.without-1.0-SNAPSHOT.jar -> java.base
mh.library.without-1.0-SNAPSHOT.jar -> jdk.net

-> To make IntelliJ work add it module-info.

-> Generate module-info.class from jar:
$ jdeps --generate-module-info generated-mods mh.library.without-1.0-SNAPSHOT.jar
As an output you get file:
module-info.java

-> Compile module-info.java to class.
javac --patch-module mh.library.without=mh.library.without-1.0-SNAPSHOT.jar module-info.java

-> Add class to jar
jar uf mh.library.without-1.0-SNAPSHOT.jar module-info.class

-> Use Jlinker:
$JAVA_HOME/bin/jlink \
--module-path $JAVA_HOME/jmods/:jars \
--add-modules mh.library.without,jdk.net \
--launcher launcherMh=moduleMh/mh.standalone.App \
--output standalone \
--strip-debug \
--compress 2 \
--no-header-files \
--no-man-pages

du -sh standalone


