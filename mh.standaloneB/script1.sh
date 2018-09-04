#!/bin/bash

rm -rf jars
rm -rf generated-mods

mvn -f ../mh.libraryB/ clean install

mkdir jars
cp ../mh.libraryB/target/mh.libraryB-1.0-SNAPSHOT.jar jars

# Generate module-info.class from jar:
# As an output you get file: module-info.java
jdeps --generate-module-info generated-mods jars/mh.libraryB-1.0-SNAPSHOT.jar


# Compile module-info.java to class.
javac --patch-module mh.libraryB=jars/mh.libraryB-1.0-SNAPSHOT.jar generated-mods/mh.libraryB/module-info.java

# Add class to jar
mv generated-mods/mh.libraryB/module-info.class module-info.class
jar uf jars/mh.libraryB-1.0-SNAPSHOT.jar module-info.class

rm -rf module-info.class
rm -rf generated-mods