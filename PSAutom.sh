#!/bin/bash


### Emoji
emoji_no_entry=⛔
emoji_check_mark_button=✅
emoji_cross_mark=❌

### Listo Color
GREEN='\033[0;32m'
RED='\033[0;31m'
WHITE='\033[0;37m'
RESET='\033[0m'

### Coniguration file path
CONFIG=./conf.ini

Check_psp () {

### Check if the PSP Console is connect to PC. ###

    lsusb|grep "PSP" &> /dev/null
    status="$?"
    if [[ $status == 0 ]];
    then
        echo -e "$GREEN Console PSP connect OK $RESET $emoji_check_mark_button"
        sleep 1s
    else
        echo -e "$RED The Console is not connected $RESET $emoji_cross_mark"
        exit 16
    fi
}

Check_PSP_mount () {
    
### Check if the PSP mount dir point is connect. ###

    PATH_PSP="/media/psychonaut/disk1"
    
    if test -d $PATH_PSP;
    then
        echo -e "$GREEN Directory PSP OK $RESET $emoji_check_mark_button"
        sleep 1s
    else
        echo -e "$RED Directory PSP not found $RESET $emoji_cross_mark"
        exit 15
    fi
}

Check_HDD () {

    HDD="JMS578"
### Check if the HDD is connect to PC. ###

    lsusb|grep $HDD &> /dev/null
    status="$?"
    if [[ $status == 0 ]];
    then
        echo -e "$GREEN HDD connect OK $RESET $emoji_check_mark_button"
        sleep 1s
    else
        echo -e "$RED The HDD is not connected $RESET $emoji_cross_mark"
        exit 17
    fi
}

Check_HDD_mount () {
    
### Check if the HDD mount point is connect to PC. ###

    PATH_HDD="/media/psychonaut/PS2_GAME"
    
    if test -d $PATH_HDD;
    then
        echo -e "$GREEN Directory HDD OK $RESET $emoji_check_mark_button"
        sleep 1s
    else
        echo -e "$RED Directory HDD not found $RESET $emoji_cross_mark"
        exit 15
    fi
}

Check_HDD_dir () {

### Check if in HDD is present the tree of direcotry. ###

    PATH_HDD="/media/psychonaut/PS2_GAME"
    ROOT=$PATH_HDD/PSP/

    if test -d $ROOT;
    then
        echo -e "$GREEN Directory root psp OK $RESET $emoji_check_mark_button"
        sleep 1s
    else
        echo -e "$RED Directory root psp not found $RESET $emoji_cross_mark"
        echo -e "Create? Yes/no"
        read choice
        if [[ $choice == 'Yes' || $choice == 'yes' ]];
        then
            cd $PATH_HDD
            mkdir -p PSP
            mkdir -p PSP/{iso,ps1,emu}
        elif [[ $choice == 'No' || $choice == 'no' ]]
        then
            echo -e "$RED You need create this directory for use the tools $RESET"
            echo "ByeBye!"
            exit 0
        fi
    fi
}

COPY_PS1 () {

### Copy the game from HDD to PSP ###

    PATH_HDD="/media/psychonaut/PS2_GAME"
    ROOT=$PATH_HDD/PSP/
    PATH_PSP="/media/psychonaut/disk1"

    cd $ROOT/ps1
    echo "Wait . . ."
    cp -rv * $PATH_PSP/PSP/GAME
    echo -e "$GREEN File Copied $RESET $emoji_check_mark_button"

}

COPY_PSP () {

### Copy the game from HDD to PSP ###

    PATH_HDD="/media/psychonaut/PS2_GAME"
    ROOT=$PATH_HDD/PSP/
    PATH_PSP="/media/psychonaut/disk1"

    cd $ROOT/iso
    echo "Wait . . ."
    cp -rv * $PATH_PSP/ISO
    echo -e "$GREEN File Copied $RESET $emoji_check_mark_button"

}

logo () {

    echo """
    
__________  _________   _____          __                  
\______   \/   _____/  /  _  \  __ ___/  |_  ____   _____  
 |     ___/\_____  \  /  /_\  \|  |  \   __\/  _ \ /     \ 
 |    |    /        \/    |    \  |  /|  | (  <_> )  Y Y  \\
 |____|   /_______  /\____|__  /____/ |__|  \____/|__|_|  /
                  \/         \/                         \/ 
BY Psychonaut
    """


}

menu () {

    logo
    Check_psp
    Check_PSP_mount
    Check_HDD
    Check_HDD_mount
    Check_HDD_dir

    echo """
        1-Copy All
        2-Copy PS1
        3-Copy PSP
        4-Exit
    """
    read choice
    if [[ $choice == 1 ]];
    then
        COPY_PS1
        COPY_PSP
    elif [[ $choice == 2 ]]
    then
        COPY_PS1
    elif [[ $choice == 3 ]]
    then
        COPY_PSP
    elif [[ $choice == 4 ]]
    then
        echo "ByeBye!"
        exit 0
    fi
}

menu
