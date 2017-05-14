#! /bin/sh
# Configure your paths and filenames
SOURCEBINPATH=.
SOURCEBIN=scpage.sh
SOURCEDOC=README.md
DEBFOLDER=scpage
WRAP=scpage-wrap
PAGE_EXAMPLE="scpage.html"
INDEX_EXAMPLE="index.html"
CSS_EXAMPLE="style.css"
LICENSE="LICENSE"
DEBVERSION=1.0
CONTROL_FILE="Source: scpage
Section: admin
Priority: optional
Maintainer: idk <eyedeekay@i2pmail.org>
Build-Depends: debhelper (>= 9)
Standards-Version: 3.9.5
Homepage: https://cmotc.github.io/scpage/
Vcs-Git: git@github.com:cmotc/scpage.git
Vcs-Browser: https://github.com/cmotc/scpage

Package: scpage
Architecture: all
Depends: \${misc:Depends}, markdown | discount
Description: Generates a Markdown-formatted description of a software package
 and a corresponding html page. For use with my repo generator, apt-now so that
 it can generate package description pages automatically and make the
 repositories easier to browse. It's a very, very basic little script. I don't
 intend to expand it or make it smarter, instead I'm going to use it by
 redirecting it's output and processing that. It uses dpkg --info to read the
 contents of your debian package, grep and sed, and doesn't need bash, so it
 should run fine on any Debian-based system.
 "
DEBFOLDERNAME="../$DEBFOLDER-$DEBVERSION"

cd $DEBFOLDER

# Create your scripts source dir
mkdir $DEBFOLDERNAME

# Copy your script to the source dir
cp $SOURCEBINPATH/$SOURCEBIN $DEBFOLDERNAME/$DEBFOLDER
cp $SOURCEBINPATH/$WRAP $DEBFOLDERNAME/$WRAP
cp $SOURCEBINPATH/$PAGE_EXAMPLE $DEBFOLDERNAME/
cp $SOURCEBINPATH/$INDEX_EXAMPLE $DEBFOLDERNAME/
cp $SOURCEBINPATH/$CSS_EXAMPLE $DEBFOLDERNAME/
cp $SOURCEBINPATH/$LICENSE $DEBFOLDERNAME/
cd $DEBFOLDERNAME

# Create the packaging skeleton (debian/*)
dh_make --indep --createorig
echo "$CONTROL_FILE" > debian/control

# Remove make calls
grep -v makefile debian/rules > debian/rules.new
mv debian/rules.new debian/rules

# debian/install must contain the list of scripts to install
# as well as the target directory
echo $DEBFOLDER usr/bin > debian/install
echo $WRAP usr/bin >> debian/install
echo $PAGE_EXAMPLE usr/share/doc/scpage >> debian/install
echo $INDEX_EXAMPLE usr/share/doc/scpage >> debian/install
echo $CSS_EXAMPLE usr/share/doc/scpage >> debian/install
echo $LICENSE usr/share/doc/scpage >> debian/install
#echo $SOURCEDOC usr/share/doc/apt-git >> debian/install

# Remove the example files
rm debian/*.ex

# Build the package.
# You  will get a lot of warnings and ../somescripts_0.1-1_i386.deb
debuild -us -uc #> ../log
