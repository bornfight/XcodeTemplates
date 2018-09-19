#!/bin/bash

if [ ! -d ~/Library/Developer/Xcode/Templates ]; then
    echo "Templates directory doesn't exist. Creating one" 
    mkdir ~/Library/Developer/Xcode/Templates
fi

for template in $(ls templates); do
    if [ -d ~/Library/Developer/Xcode/Templates/$template ]; then
        echo -e "Previous version of template\033[1;31m $template\033[0m found. Updating..."
        rm -rf ~/Library/Developer/Xcode/Templates/$template
    fi
    cp -r templates/$template ~/Library/Developer/Xcode/Templates/$template
done

echo "Install complete. Please restart XCode (if applicable)."
