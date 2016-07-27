#! /bin/sh
install_scpage(){
        sudo cp scpage.sh /usr/local/bin/scpage
        sudo chmod a+x /usr/local/bin/scpage
        sudo cp scpage-wrap /usr/local/bin/scpage-html
        sudo chmod a+x /usr/local/bin/scpage-html
#        sudo cp hdpage.sh /usr/local/bin/hdpage
#        sudo chmod a+x /usr/local/bin/hdpage
}
remove_scpage(){
        sudo rm /usr/local/bin/scpage
        sudo rm /usr/local/bin/scpage-html
}
if [ $1="install " ]; then
        install_scpage
elif [ $1="remove " ]; then
        remove_scpage
else
        echo " \"install\" or \"remove\"! I don't know what I'm supposed to do!"
fi
