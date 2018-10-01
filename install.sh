#!/bin/bash

if [ ! -d ~/Library/Developer/Xcode/Templates ]; then
    echo "Templates directory doesn't exist. Creating one" 
    mkdir ~/Library/Developer/Xcode/Templates
fi

for template in $(ls templates); do
    if [ -d ~/Library/Developer/Xcode/Templates/$template ]; then
        template_name=$(echo $template| rev | cut -c 12- | rev)
        echo -e "Previous version of\033[1;31m $template_name\033[0m template found. Updating..."
        rm -rf ~/Library/Developer/Xcode/Templates/$template
    else 
    	echo -e "New\033[1;32m $template_name\033[0m template found. Installing..."
    fi
    cp -r templates/$template ~/Library/Developer/Xcode/Templates/$template
done

echo "🔥 Install complete. Please restart Xcode (if applicable). 🔥"
