#!/bin/bash
# Author:    Pedro Esteves
# Date:     2019-07-10

# Setting environment variables
JAVA=$(which java)
JAVAD="./java-decompiler.jar"
JAVA_ARGS="-cp"
JAVA_CLASS="org.jetbrains.java.decompiler.main.decompiler.ConsoleDecompiler"
WORKING_DIR=$1

#Logging Function
function log(){
DATE=$(date +'%Y-%m-%d %H:%M:%S')
echo $DATE - $1
}

#Main body of the script 
cd $WORKING_DIR
LIST=$(find . -name "*.class")
count=$( echo $LIST | sed 's/ /\n/g' | wc -l)
log "Found $count classes on $WORKING_DIR"
log "$LIST"
for CLASS in $LIST
do
CLASS_PATH=$( echo $CLASS | perl -pe 's/(.*\/)(.*class)/$1/' )
log "Starting Decompilation of $CLASS at $CLASS_PATH"
$JAVA $JAVA_ARGS $JAVAD $JAVA_CLASS $CLASS $CLASS_PATH 
log "Successfully Decompiled $CLASS"
done