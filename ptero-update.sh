#!/bin/bash
if [ "$EUID" -ne 0 ]
then echo "Please run as root, Quitting script"
exit
fi
read -p "Press 0 for Wings Update, Press 1 for Panel Update or press 2 to update Both" CHECK 

if [ "$CHECK" = 0 ];
then
	curl -L -o /usr/local/bin/wings "https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_$([[ "$(uname -m)" == "x86_64" ]] && echo "amd64" || echo "arm64")"
	chmod u+x /usr/local/bin/wings
	echo "Wings Update Complete, restarting Wings"
	sleep 0.4
	systemctl restart wings 
	sleep 0.4
	echo "Wings Restarted"
fi

if [ "$CHECK" = 1 ];
then
	cd /var/www/pterodactyl
	php artisan down
	curl -L https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz | tar -xzv
	chmod -R 755 storage/* bootstrap/cache
	php artisan route:clear && php artisan cache:clear && php artisan view:clear
	chown -R www-data:www-data /var/www/pterodactyl/*
	php artisan queue:restart
	php artisan up
	sleep 5.0
	echo "Panel Update Completed"
fi

if [ "$CHECK" = 2 ];
then
	cd /var/www/pterodactyl
	php artisan down
	curl -L https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz | tar -xzv
	chmod -R 755 storage/* bootstrap/cache
	php artisan route:clear && php artisan cache:clear && php artisan view:clear
	chown -R www-data:www-data /var/www/pterodactyl/*
	php artisan queue:restart
	php artisan up
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

fi
echo "Updated Pterodactyl"
sleep 3
echo "Quitting script"

