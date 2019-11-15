#!/bin/sh

show_menu(){
  NORMAL=`echo "\033[m"`
  MENU=`echo "\033[36m"`
  NUMBER=`echo "\033[33m"`
  FGRED=`echo "\033[41m"`
  RED_TEXT=`echo "\033[31m"`
  ENTER_LINE=`echo "\033[33m"`
  echo -e "${MENU}*********************************************${NORMAL}"
  echo -e "${MENU}**${NUMBER} 1)${MENU} Get Dataset ${NORMAL}"
  echo -e "${MENU}**${NUMBER} 2)${MENU} Preprocessing Data ${NORMAL}"
  echo -e "${MENU}**${NUMBER} 3)${MENU} Run All Models ${NORMAL}"
  echo -e "${MENU}**${NUMBER} 4)${MENU} Run Model - Breeds ${NORMAL}"
  echo -e "${MENU}**${NUMBER} 5)${MENU} Run Model - Cat Breeds ${NORMAL}"
  echo -e "${MENU}**${NUMBER} 6)${MENU} Run Model - Dog Breeds ${NORMAL}"
  echo -e "${MENU}**${NUMBER} 7)${MENU} Run Model - Species ${NORMAL}"
  echo -e "${MENU}*********************************************${NORMAL}"
  echo -e "${ENTER_LINE}Please enter a menu option and enter or ${RED_TEXT} enter to exit. ${NORMAL}"
  read opt

  while [ opt != '' ]
  do
    if [[ $opt = "" ]]; then
      exit;
    else
      case $opt in
      1) clear;
      option_picked "Get Dataset";
      bash scripts/get_dataset.sh
      ;;

      2) clear;
      option_picked "Preprocessing Data";
      python3 src/breeds/data_preprocessing.py
      python3 src/cat_breeds/data_preprocessing.py
      python3 src/dog_breeds/data_preprocessing.py
      python3 src/species/data_preprocessing.py
      show_menu
      ;;

      3) clear;
      option_picked "Run All Models";    
      python3 src/breeds/build_model.py
      python3 src/cat_breeds/build_model.py
      python3 src/dog_breeds/build_model.py
      python3 src/species/build_model.py
      ;;

      4) clear;
      option_picked "Run Model - Breeds";    
      python3 src/breeds/build_model.py
      ;;

      5) clear;
      option_picked "Run Model - Cat Breeds";    
      python3 src/cat_breeds/build_model.py
      ;;

      6) clear;
      option_picked "Run Model - Dog Breeds";    
      python3 src/dog_breeds/build_model.py
      ;;

      7) clear;
      option_picked "Run Model - Species";    
      python3 src/species/build_model.py
      ;;

      x)exit;
      ;;

      \n)exit;
      ;;

      *)clear;
      option_picked "Pick an option from the menu";
      show_menu;
      ;;
      esac
    fi
  done
}

function option_picked() {
  COLOR='\033[01;31m'
  RESET='\033[00;00m'
  MESSAGE=${@:-"${RESET}Error: No message passed"}
  echo -e "${COLOR}${MESSAGE}${RESET}"
}

pyclean () {
  find . -regex '^.*\(__pycache__\|\.py[co]\)$' -delete
}

clear
show_menu
