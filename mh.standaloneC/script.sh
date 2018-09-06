#!/bin/bash
# [INFO] mh:mh.standaloneC:jar:1.0-SNAPSHOT
# [INFO] \- org.apache.poi:poi-scratchpad:jar:3.17:compile
# [INFO]    \- org.apache.poi:poi:jar:3.17:compile
# [INFO]       +- commons-codec:commons-codec:jar:1.10:compile
# [INFO]       \- org.apache.commons:commons-collections4:jar:4.1:compile

#create if not exist
mkdir -p jars_original
#download if not exist
wget -nc https://repo.maven.apache.org/maven2/org/apache/poi/poi-scratchpad/3.17/poi-scratchpad-3.17.jar -P jars_original/
wget -nc https://repo.maven.apache.org/maven2/org/apache/poi/poi/3.17/poi-3.17.jar -P jars_original/
wget -nc https://repo.maven.apache.org/maven2/commons-codec/commons-codec/1.10/commons-codec-1.10.jar -P jars_original/
wget -nc https://repo.maven.apache.org/maven2/org/apache/commons/commons-collections4/4.1/commons-collections4-4.1.jar -P jars_original/
wget -nc http://central.maven.org/maven2/commons-logging/commons-logging/1.2/commons-logging-1.2.jar -P jars_original/

#https://mvnrepository.com/artifact/commons-logging/commons-logging

rm -rf jars
mkdir jars

# -------------- commons-codec
cp jars_original/commons-codec-1.10.jar jars/
cd jars
jdeps --generate-module-info generated-mods commons-codec-1.10.jar
mv generated-mods/commons.codec/module-info.java module-info.java
javac --patch-module commons.codec=commons-codec-1.10.jar module-info.java
jar uf commons-codec-1.10.jar module-info.class

rm -rf generated-mods/
rm -rf module-info.java
rm -rf module-info.class

#mkdir commons-codec
#cp commons-codec-1.10.jar commons-codec/
#cd commons-codec/
#jar xf commons-codec-1.10.jar
#cd ../..

cd ..

#---------------- commons-collections4
cp jars_original/commons-collections4-4.1.jar jars/
cd jars
jdeps --generate-module-info generated-mods commons-collections4-4.1.jar
mv generated-mods/commons.collections4/module-info.java module-info.java
javac --patch-module commons.collections4=commons-collections4-4.1.jar module-info.java
jar uf commons-collections4-4.1.jar module-info.class

rm -rf generated-mods/
rm -rf module-info.java
rm -rf module-info.class

#mkdir commons-collections4
#cp commons-collections4-4.1.jar commons-collections4/
#cd commons-collections4/
#jar xf commons-collections4-4.1.jar
#cd ../..

cd ..

#---------------- commons-logging
cp jars_original/commons-logging-1.2.jar jars/
cp commons-logging/module-info.java jars/module-info.java
cd jars
#jdeps --generate-module-info generated-mods commons-logging-1.2.jar
javac --patch-module commons.logging=commons-logging-1.2.jar module-info.java
jar uf commons-logging-1.2.jar module-info.class

rm -rf module-info.java
rm -rf module-info.class

#mkdir commons-logging
#cp commons-logging-1.2.jar commons-logging/
#cd commons-logging/
#jar xf commons-logging-1.2.jar
#cd ../..

cd ..
#---------------- poi + poi-scratchpad
rm -rf jars_poi
mkdir jars_poi
cp jars_original/poi-3.17.jar jars_poi/
cp jars_original/poi-scratchpad-3.17.jar jars_poi/
cd jars_poi/

jar xf poi-3.17.jar
jar xf poi-scratchpad-3.17.jar

rm -rf poi-3.17.jar
rm -rf poi-scratchpad-3.17.jar

jar -cvf poi-full.jar .

cd ..
cp jars_poi/poi-full.jar jars/
rm -rf jars_poi/
cd jars/

jdeps --module-path . --add-modules commons.codec,commons.collections4,commons.logging --generate-module-info generated-mods poi-full.jar
mv generated-mods/poi.full/module-info.java module-info.java
javac --module-path . --add-modules commons.codec,commons.collections4,commons.logging --patch-module poi.full=poi-full.jar module-info.java
jar uf poi-full.jar module-info.class

rm -rf generated-mods/
rm -rf module-info.java
rm -rf module-info.class

cd ..
pwd

#----------------------------- JLINK
mvn clean install
cp target/mh.standaloneC-1.0-SNAPSHOT.jar jars

$JAVA_HOME/bin/jlink \
--module-path $JAVA_HOME/jmods/:jars \
--add-modules moduleMhC \
--launcher launcherMh=moduleMhC/mh.standaloneC.App \
--output standalone \
--strip-debug \
--compress 2 \
--no-header-files \
--no-man-pages

du -sh standalone

standalone/bin/launcherMh