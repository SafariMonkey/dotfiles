DOTFILES = $(shell pwd)

# Install $(1) from AUR, using ~/tmp/aur/$(1) as build directory
AUR_INSTALL = ([[ -e ~/tmp/aur/$(1) ]] && (cd ~/tmp/aur/$(1) && git pull) || git clone https://aur.archlinux.org/$(1) ~/tmp/aur/$(1)) && (cd ~/tmp/aur/$(1) && makepkg -sri)

.PHONY: arch-packages
arch-packages:
	# make temp dir for AUR installs
	mkdir -p ~/tmp/aur
	
	# change PKGEXT to .pkg.tar, we don't need compression for AUR builds
	sudo sed -i "s/PKGEXT='.pkg.tar.xz'/PKGEXT='.pkg.tar'/" /etc/makepkg.conf
	
	# Install cower and yay
	$(call AUR_INSTALL,yay)
	
	yay -S tig python python2 htop nmap fzf

.PHONY: arch-gui-packages
arch-gui-packages:
	yay -S xorg-xinit i3 dmenu termite feh \
	          pulseaudio pavucontrol pulseaudio-alsa \
	          bluez bluez-utils \
	          noto-fonts noto-fonts-emoji noto-fonts-cjk \
	          ttf-dejavu evince baudline-bin thunderbird \
	          py3status-git scrot graphicsmagick jq tmux

.PHONY: arch-lib32
arch-lib32:
	# enable multilib and update package list
	sudo sed -i "s|#[multilib]|[multilib]\nInclude = /etc/pacman.d/mirrorlist|" /etc/pacman.conf
	yay -Syu
	
	# install packages
	yay -S lib32-libpulse steam

.PHONY: python-packages
python-packages:
	yay -S python2-pip
	pip2 install --user hvac etcd==2.0.2 python-etcd==0.4.4 docker-py websocket-client==0.32.0
	pip2 install --user --extra-index-url http://pypi.bespin.nboss.ntt.net/pypi --trusted-host pypi.bespin.nboss.ntt.net metro
	yay -S python2-docopt python2-redis python2-trollius python2-voluptuous python2-termcolor python2-tabulate python2-gevent python2-yaml python2-tox python2-jinja python2-docker-pycreds

.PHONY: configs
configs:
	./joinTheDots
	chmod 700 ~/.ssh

.PHONY: git-prompt
git-prompt:
	mkdir -p ~/bin/includes
	curl -o ~/bin/includes/git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

.PHONY: vim-plugins
vim-plugins:
	git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall

define github_clone
	mkdir -p ~/git
	[ -e $(2) ] || git clone https://github.com/$(1) $(2)
	(cd $(2) && git remote set-url origin git@github.com:$(1))
endef

.PHONY: git-repos
git-repos:
	mkdir -p ~/git
	$(call github_clone,kragen/xcompose,~/git/xcompose)
	$(call github_clone,ccontavalli/ssh-ident,~/git/ssh-ident)
	ln -s ~/git/ssh-ident/ssh-ident ~/bin/ssh

.PHONY: non-arch-git-repos
non-arch-git-repos:
	$(call github_clone,icy/pacapt,~/git/pacapt)

.PHONY: dunst
dunst:
	$(call github_clone,dunst-project/dunst,$(DOTFILES)/packages/dunst/src/dunst)
	cd $(DOTFILES)/packages/dunst/src/dunst && \
		git checkout -- . && \
		git apply $(DOTFILES)/packages/dunst/patch.diff
	cd $(DOTFILES)/packages/dunst && \
		makepkg -efsri

.PHONY: generic
generic: configs git-prompt vim-plugins git-repos

.PHONY: non-arch
non-arch: generic non-arch-git-repos

.PHONY: arch
arch: generic arch-packages

.PHONY: arch-gui
arch-gui: arch arch-gui-packages

.PHONY: arch-gui32
arch-gui32: arch-gui arch-lib32
