#!/usr/bin/env bash
# Dependency: git

FP="/usr/share/fonts/TTF"

while [ $# -gt 0 ]; do
	case "$1" in
		-h | --help)
			echo "-fp, --fontpath	- Sets the target installation path of TTF fonts. Default is /usr/share/fonts/TTF."
			echo "-w, --which   	- Parses Xorg log to discover the font path."
			exit;;
		-w | --which)
			grep /fonts /var/log/Xorg.0.log
			exit;;
		-f | --fontpath)
			shift
			FP=$1;;
	esac
	shift
done

# Main code.			
git clone https://github.com/google/fonts.git /tmp/google_fonts

while read -r line
do
	sudo mv "$line" "$FP"
done < <(find /tmp/google_fonts -type f | grep ttf)

rm -rf /tmp/google_fonts
