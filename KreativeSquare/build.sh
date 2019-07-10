#!/usr/bin/env bash

if command -v fontforge >/dev/null 2>&1; then
	FONTFORGE="fontforge"
elif test -f /Applications/FontForge.app/Contents/Resources/opt/local/bin/fontforge; then
	FONTFORGE="/Applications/FontForge.app/Contents/Resources/opt/local/bin/fontforge"
else
	echo "Could not find FontForge."
	exit 1
fi

if command -v ttf2eot >/dev/null 2>&1; then
	TTF2EOT="ttf2eot"
else
	echo "Could not find ttf2eot."
	exit 1
fi

# Clean
rm -f KreativeSquare.sfd-* KreativeSquare.ttf KreativeSquare.eot KreativeSquare.zip
rm -rf kreativesquare

# Generate ttf
$FONTFORGE -lang=ff -c 'i = 1; while (i < $argc); Open($argv[i]); Generate($argv[i]:r + ".ttf", "", 128); i = i+1; endloop' KreativeSquare.sfd

# Convert to eot
$TTF2EOT < KreativeSquare.ttf > KreativeSquare.eot

# Create zip
zip KreativeSquare.zip OFL.txt KreativeSquare.ttf KreativeSquare.eot

# Create lowercase versions
mkdir kreativesquare
cp KreativeSquare.ttf kreativesquare/kreativesquare.ttf
cp KreativeSquare.eot kreativesquare/kreativesquare.eot
cp KreativeSquare.zip kreativesquare/kreativesquare.zip