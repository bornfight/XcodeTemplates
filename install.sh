#!/bin/bash

if [ ! -d ~/Library/Developer/Xcode/Templates ]; then
    echo "Templates directory doesn't exist. Creating one for you..." 
    mkdir ~/Library/Developer/Xcode/Templates
fi

cp -r $PWD/templates/ ~/Library/Developer/Xcode/Templates/
echo "Install complete. Please restart XCode (if applicable)."
