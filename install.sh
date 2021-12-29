#!/bin/bash

readonly BIN_DIRECTORY="/usr/local/bin"
readonly CONFIG_DIRECTORY="/etc/ssmtp"

#Fonction création du fichier de configuration
function createFileConfig()
{
    cp config/configfile $CONFIG_DIRECTORY/config
    if [ -f $CONFIG_DIRECTORY/config ] 
    then
        echo "Mise en place de fichier de configuration effectué dans le dossier $CONFIG_DIRECTORY"
    else
        echo "Impossible de créer le fichier $CONFIG_DIRECTORY/config, veuillez vérifier les ACLs"
    fi
}


echo "Début installation SSMTP"
if [ $(lsb_release -si) == "Debian" ] || [ $(lsb_release -si) == "Ubuntu" ]
then
    if [ -d $BIN_DIRECTORY ]
    then
        cp lib/ssmtp $BIN_DIRECTORY/ssmtp
        if [ -f $BIN_DIRECTORY/ssmtp ] 
        then
            echo "Mise en place de la librairie effectué"
        else
            echo "Impossible de crée le dossier $BIN_DIRECTORY, veuillez vérifier les ACLs"
            exit 100
        fi
        if [ -d $CONFIG_DIRECTORY ] && [ -f $CONFIG_DIRECTORY/config ]
        then
            echo "Fichier de configuration déjà existant, souhaitez vous le garder ? [Y/N]"
            read input
            case $input in
            Y | y | yes | oui | TRUE) keepConfig=TRUE
            ;;
            N | n | no | non) keepConfig=FALSE
            ;;
            *) echo "Merci de rentrer une réponse valide (yes ou no), interruption de l'installation"
            exit 102
            ;;
            esac

            if [ $keepConfig == TRUE ] 
            then
                echo "Le fichier de configuration actuelle est gardé"
            else
                createFileConfig
            fi
        else
            mkdir $CONFIG_DIRECTORY
            if [ -d $CONFIG_DIRECTORY ] 
            then
                createFileConfig
            else
                echo "Impossible de crée le dossier $CONFIG_DIRECTORY, veuillez vérifier les ACLs"
                exit 100
            fi
        fi
    else
        echo "Le dossier $BIN_DIRECTORY n'existe pas"
        exit 101
    fi
else
    echo "Distribution non pris en charge"
    echo "L'installation nécessite la distribution Debian ou Ubuntu"
fi

