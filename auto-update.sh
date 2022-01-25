curl -L -o /usr/local/bin/wings "https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_$([[ "$(uname -m)" == "x86_64" ]] && echo "amd64" || echo "arm64")"
chmod u+x /usr/local/bin/wings
echo "Wings Update Complete, restarting Wings\n"
sleep 0.4
echo "Wings Update Complete, restarting Wings\n."
echo "Wings Update Complete, restarting Wings\n.."
sleep 0.1
echo "Wings Update Complete, restarting Wings\n..."
sleep 0.1
echo "Wings Update Complete, restarting Wings\n...."
sleep 0.1
systemctl restart wings
sleep 0.5
echo "Wings Restarted, Quitting script"


