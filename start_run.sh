#!/bin/bash
sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/' /home/ubuntu/.bashrc
sudo sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/' /root/.bashrc

echo 'alias a="sudo -i"' >> /home/ubuntu/.bashrc

sudo hostname react-server
echo react-server | sudo tee /etc/hostname
echo '' | sudo tee -a /etc/hosts
echo "127.0.0.1 react-server" | sudo tee -a /etc/hosts


sudo apt update
sudo apt update


sudo apt install nginx -y
sudo useradd -m -s /bin/bash -c "react-user" react-user


sudo usermod --password $(echo password | openssl passwd -1 -stdin) react-user
echo 'react-user ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/react-user
echo '' | sudo tee -a /etc/ssh/sshd_config
echo 'Match User react-user
    PasswordAuthentication yes' | sudo tee -a /etc/ssh/sshd_config
sudo /etc/init.d/ssh restart


sudo tar -xvzf /tmp/react.tar.gz -C /var/www/html/
sudo mv /var/www/html/build/* /var/www/html/
sudo rm -rf /var/www/html/build/

sudo chown react-user:react-user /var/www/ -R

echo "************************** ALL DONE ****************************************"

