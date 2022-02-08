#!/bin/bash
if [ "$EUID" -ne 0 ]
then echo "Please run as root, Quitting script"
exit
fi
read -p $'Press 0 for Wings Update, Press 1 for Panel Update or press 2 to update Both\n' CHECK 

	if [ "$CHECK" = 0 ];
	then
		curl -L -o /usr/local/bin/wings "https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_$([[ "$(uname -m)" == "x86_64" ]] && echo "amd64" || echo "arm64")"
		chmod u+x /usr/local/bin/wings
		echo "Wings Update Complete, restarting Wings"
		sleep 0.4
		systemctl restart wings 
		sleep 0.4
		echo "Wings Restarted"
		echo "Quitting Script"
	fi

	if [ "$CHECK" = 1 ];
	then
		cd /var/www/pterodactyl && php artisan p:upgrade
		echo "Panel Update Completed"
		echo "Quitting Script"
	fi

	if [ "$CHECK" = 2 ];
	then
		cd /var/www/pterodactyl && php artisan p:upgrade
		sleep 2
		echo "Panel Update Completed"
		curl -L -o /usr/local/bin/wings "https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_$([[ "$(uname -m)" == "x86_64" ]] && echo "amd64" || echo "arm64")"
		chmod u+x /usr/local/bin/wings
		echo "Wings Update Complete, restarting Wings"
		sleep 0.4
		systemctl restart wings 
		sleep 0.4
		echo "Wings Restarted"
		sleep 2
		echo "Updated Pterodactyl, Quitting Script"

	fi




