# SimpleSMTP

Script permettant d'envoyer des mails depuis n'importe quel environnement linux via CURL.

Comment l'installer ? 

- Copier de dépot en local avec la commande suivante : 
git clone git@github.com:AKrIMa59/SimpleSMTP.git

- Lancer l'installeur :
./install.sh

// Les fichiers seront déployés dans /etc/ssmtp et /usr/local/bin

Comment l'utiliser ?

- Le script est utilisable dans n'importe quel dossier avec la command "ssmtp <arg>", vous pouvez retrouver le détail des arguments avec la commande ssmtp --help

Utiliser la commande dans Cron

exemple : 0 5 * * * /bin/bash /usr/local/bin/ssmtp -e email@domain.com -o "Object" -c file-content.txt