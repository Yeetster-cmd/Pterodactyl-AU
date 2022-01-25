#!/bin/bash
if [ "$EUID" -ne 0 ]
then echo "Please run as root, Quitting script"
exit
fi
cd /var/www/pterodactyl
php artisan down
curl -L https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz | tar -xzv
chmod -R 755 storage/* bootstrap/cache
php artisan route:clear && php artisan cache:clear && php artisan view:clear
chown -R www-data:www-data /var/www/pterodactyl/*
php artisan queue:restart
php artisan up
sleep 5.0
echo "Panel Update Completed, Quitting script"
