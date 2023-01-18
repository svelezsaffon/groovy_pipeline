#!/bin/bash

echo 'Configuring additional steps'

PLATFORM=$1

SCONS_PARAMS=$2

echo "this fedora ${FINAL_IMAGE}"


if [ "$PLATFORM" = "linux" ]; then
    
    echo "Deafaulting to x86_32 CPU architecture"
    

elif [ "$PLATFORM" = "windows" ]; then
    
    echo "Deafaulting to X86_64 CPU architecture"
    
    
else
    echo "Unknown architecture ${ARCHITECTURE}"
    exit 1
fi



scons -j6 platform=${PLATFORM} ${SCONS_PARAMS}