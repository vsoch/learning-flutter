#!/bin/bash

# This is intended to be run after creating the Singularity container
# with flutter bound, and shelling inside.

flutter channel beta
flutter upgrade
flutter config --enable-web
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 
/usr/local/android-sdk/tools/bin/sdkmanager --update
yes | flutter doctor --android-licenses
