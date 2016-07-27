#! /bin/bash

while getopts ":f:" opt; do
  case $opt in
    f)
      echo "-f using file: $OPTARG" > /dev/null
      PKG_FILE=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done
if [ ! -f $PKG_FILE ]; then
    echo "Package file not found" >&2
    exit 1
fi

cd $PWD
PKG_INFO=$(cat $PKG_FILE)

PKGFILEBIN=$(cat $PKG_FILE | grep 'Package:' | sed -e 's/^[ \t]*//')
HONE="============="
printf "%b\n" "\n<div id=\"header\">\n"
[ ! -z "$PKGFILEBIN" ] && printf "%b\n" "$PKGFILEBIN \n$HONE \n" | tee $PKG_FILE.md | markdown
PKGFILESRC=$(cat $PKG_FILE | grep 'Source:' | sed -e 's/^[ \t]*//')
HTWO="-------------"
[ ! -z "$PKGFILESRC" ] && printf "%b\n" "$PKGFILESRC \n$HTWO \n" | tee -a $PKG_FILE.md | markdown
printf "%b\n" "\n</div>\n"
printf "%b\n" "\n<div id=\"content\">\n"
PKGFILEVER=$(echo -n "###" && cat $PKG_FILE | grep 'Version:' | sed -e 's/^[ \t]*//')
PKGFILEMAN=$(echo -n "####" && cat $PKG_FILE | grep 'Maintainer:' | sed -e 's/^[ \t]*//')
PKGFILEDEP=$(cat $PKG_FILE | grep 'Build-Depends:' | sed -e 's/^[ \t]*//' | sed -e 's/Depends:/###Depends:\n  */')
PKGFILEREC=$(cat $PKG_FILE | grep 'Vcs-Browser:' | sed -e 's/^[ \t]*//' | sed -e 's/Recommends:/###Recommends:\n  */')
[ ! -z "$PKGFILEVER" ] && printf "%b\n" "$PKGFILEVER" | tee -a $PKG_FILE.md | markdown
[ ! -z "$PKGFILEMAN" ] && printf "%b\n" "$PKGFILEMAN" | tee -a $PKG_FILE.md | markdown
[ ! -z "$PKGFILEDEP" ] && printf "%b\n" "$PKGFILEDEP" | tee -a $PKG_FILE.md | markdown
[ ! -z "$PKGFILEREC" ] && printf "%b\n" "$PKGFILEREC" | tee -a $PKG_FILE.md | markdown
printf "%b\n" "\n</div>\n"
printf "%b\n" "\n<div id=\"sidebar\">\n"
PKGFILEPRV=$(cat $PKG_FILE | grep 'Provides:' | sed -e 's/^[ \t]*//' | sed -e 's/Provides:/###Provides:\n  */')
PKGFILESEC=$(echo -n "####" && cat $PKG_FILE | grep 'Architecture:' | sed -e 's/^[ \t]*//')
PKGFILEPRI=$(echo -n "####" && cat $PKG_FILE | grep 'Binary:' | sed -e 's/^[ \t]*//')
PKGFILESIZ=$(echo -n "####" && cat $PKG_FILE | grep 'Vcs-Git:' | sed -e 's/^[ \t]*//')
PKG_URL=$(cat $PKG_FILE | grep 'Homepage:' | sed -e 's/Homepage:/ /' | sed -e 's/^[ \t]*//') #)
PKGFILEURL=$(cat $PKG_FILE | grep 'Homepage:' | sed -e 's/^[ \t]*//' | sed -e 's/Homepage:/Homepage:[/' | tr "\n" " " && echo "]($PKG_URL)")
[ ! -z "$PKGFILEURL" ] && printf "%b\n" "$PKGFILEURL" | tee -a $PKG_FILE.md | markdown
[ ! -z "$PKGFILEPRV" ] && printf "%b\n" "$PKGFILEPRV" | tee -a $PKG_FILE.md | markdown
[ ! -z "$PKGFILESEC" ] && printf "%b\n" "$PKGFILESEC" | tee -a $PKG_FILE.md | markdown
[ ! -z "$PKGFILESIZ" ] && printf "%b\n" "$PKGFILESIZ" | tee -a $PKG_FILE.md | markdown
[ ! -z "$PKGFILEPRI" ] && printf "%b\n" "$PKGFILEPRI" | tee -a $PKG_FILE.md | markdown
printf "%b\n" "\n</div>\n"
