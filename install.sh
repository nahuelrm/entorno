#! /bin/sh

echo "Would you like to enable network services? [y/n]"
read answer

if [ $answer == y ]
then
	echo "Enabling network services..."
	sudo systemctl enable NetworkManager
	sudo systemctl enable wpa_supplicant.service
	sleep 2
	clear
fi

echo "Would you like to add your video drivers? [y/n]"
read answer

if [ $answer == y ]
then
	echo "Add bellow your video drivers below:"
	read packages
	until sudo pacman -S $packages; do
		sleep 2
		clear
		echo "Rewrite the packages names:"
		read packages
	done
	sleep 2
	clear
fi

echo "Would you like to install more packages? [y/n]"
read answer

if [ $answer == y ]
then
	sudo pacman -S xorg xorg-server xorg-xinit firefox pavucontrol pulseaudio ranger bspwm sxhkd rofi flameshot nitrogen picom kitty git xclip wget p7zip zip unzip pacman-contrib neofetch htop gcc nautilus udisks2 firejail discord obs-studio libreoffice vlc code gdm zsh pacman-contrib linux-headers v4l2loopback-dkms locate lsd bat mdcat arch-install-scripts
	sudo systemctl enable gdm.service

	sleep 2
	clear
fi


echo "Would you like to install yay? [y/n]"
read answer

if [ $answer == y ]
then 
	user="$(whoami)"
	mkdir -p ~/Desktop/$user/repos
	git clone https://aur.archlinux.org/yay-git.git
	mv yay-git ~/Desktop/$user/repos
	cd ~/Desktop/$user/repos/yay-git
	makepkg -si
	sleep 2
	clear
fi

echo "Would you like to continue installing the rest of dependencies and fonts? [y/n]"
read answer

if [ $answer == y ]
then 
	yay -S polybar scrub clipit rockyou betterlockscreen nerd-fonts-jetbrains-mono ttf-font-awesome ttf-font-awesome-4 ttf-material-design-icons ttf-font-awesome-5 ttf-ubuntu-font-family
	
	sudo wget http://fontlot.com/downfile/5baeb08d06494fc84dbe36210f6f0ad5.105610 -O /usr/share/fonts/comprimido.zip

	sudo unzip /usr/share/fonts/comprimido.zip -d /usr/share/fonts
	sudo find /usr/share/fonts | grep ".ttf$" | while read line; do cp $line /usr/share/fonts; done
	sudo rm -r /usr/share/fonts/iosevka-2.2.1  
	sudo rm -r /usr/share/fonts/iosevka-slab-2.2.1  
	sudo rm /usr/share/fonts/comprimido.zip
	
	sudo wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip -O /usr/share/fonts/Hack.zip
	sudo unzip /usr/share/fonts/Hack.zip -d /usr/share/fonts
	sudo rm /usr/share/fonts/Hack.zip
	sleep 2
	clear
fi

echo "Would you like to continue setting up the dotfiles? [y/n]"
read answer

if [ $answer == y ]
then 
	user="$(whoami)"
	git clone https://github.com/nxhuigod/entorno ~/Desktop/$user/repos/entorno
	cp -r ~/Desktop/$user/repos/entorno/dotfiles/* ~/.config
	cp ~/Desktop/$user/repos/entorno/dotfiles/.zshrc ~/.zshrc
	cp -r ~/Desktop/$user/repos/entorno/wallpapers ~/Desktop/

	sudo chmod 755 ~/.config/bspwm/bspwmrc
	sudo chmod 644 ~/.config/sxhkd/sxhkdrc
	sudo chmod +x ~/.config/kitty/kitty.conf

	sudo cp /home/$user/Desktop/$user/repos/entorno/scripts/polybar-setup.sh /bin/polybar-setup.sh
	sudo chmod +x /bin/polybar-setup.sh
        sudo cp /home/$user/Desktop/$user/repos/entorno/scripts/pserver /bin/pserver
        sudo chmod +x /bin/pserver

	sudo ln -sf /home/$user/.config/nvim /root/.config/nvim
	sudo ln -sf /home/$user/.config/ranger /root/.config/ranger

	echo "@theme "\"/home/$user/.config/rofi/themes/nord.rasi"\"" > ~/.config/rofi/config.rasi

	betterlockscreen -u /home/$user/Desktop/wallpapers/samurai-17-3840×2160.jpg
	# git clone seclist

	sleep 2
	clear
fi

echo "Would you like to add your custom services? (only for me)[y/n]"
read answer

if [ $answer == y ]
then
	sudo cp /home/$user/Desktop/$user/repos/entorno/services/etc-systemd-system/set-up.service /etc/systemd/system/ 
	sudo cp /home/$user/Desktop/$user/repos/entorno/services/usr-local-sbin/* /usr/local/sbin/ 

	sudo systemctl enable set-up.service

	yay -S 8188eu-aircrack-dkms-git virtualbox-ext-oracle
fi

echo "Would you like to install blackarch repositories? [y/n]"
read answer

if [ $answer == y ]
then
	user="$(whoami)"
	mkdir ~/Desktop/$user/repos/blackarch
	curl https://blackarch.org/strap.sh > ~/Desktop/$user/repos/blackarch/strap.sh

	chmod +x ~/Desktop/$user/repos/blackarch/strap.sh
	sed -i.bak -e '173d' ~/Desktop/$user/repos/blackarch/strap.sh
	sudo ~/Desktop/$user/repos/blackarch/strap.sh

	sleep 2 
	clear
fi

echo "Would you like to set up your zsh? [y/n]"
read answer

if [ $answer == y ]
then
	user="$(whoami)"
	sudo usermod --shell /usr/bin/zsh $user
	yay -S zsh-syntax-highlighting zsh-autosuggestions
	sudo updatedb
	sudo mkdir /usr/share/zsh-sudo
	sudo chown $user:$user /usr/share/zsh-sudo
	wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh -O /usr/share/zsh-sudo/sudo.plugin.zsh

	# powerLevel10k
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
	cp ~/Desktop/$user/repos/entorno/dotfiles/.p10k.zsh ~/.p10k.zsh

	sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/powerlevel10k
	sudo cp ~/Desktop/$user/repos/entorno/dotfiles/.root-p10k.zsh /root/.p10k.zsh  

	sudo usermod --shell /usr/bin/zsh root

	sudo ln -sf /home/$user/.zshrc /root/.zshrc

	sleep 2 
	clear
fi

echo "Would you like to install more goated things? [y/n]"
read answer

if [ $answer == y ]
then
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf 
	~/.fzf/install

	sudo git clone --depth 1 https://github.com/junegunn/fzf.git /root/.fzf  
	sudo /root/.fzf/install 

	echo "write :PlugInstall"
	sleep 3
	nvim
	sudo nvim
	clear
fi

echo "Configure firefox + addons, and reboot after all""























