# Overview of this script is running an automated installation workflow that goes step by step below:
# 1. Github setup
# 2. Install XCode
# 3. Install Homebrew
# 4. Install Development tools (programming languages, libraries, etc)
# 5. Setting up Mac settings
# Done!

developer_utilities_setup() {
	echo "Installing tree, wget, trash, mackup, and node..."
	brew install tree
	brew install wget
	brew install trash
	# brew install svn
	brew install mackup
	brew install node
}

browser_install_setup() {
	browsers=(
		firefox
		google-chrome
  )

	echo "installing appropriate browsers with Cask..."
	brew install --cask --appdir="/Applications" ${browsers[@]}
	brew cask cleanup
	brew cleanup
}

git_setup() {
	echo "Installing Git..."
	brew install git

	echo "Installing brew git utilities..."
	brew install git-extras
	brew install legit
	brew install git-flow
}

github_setup() {
	echo "Creating an SSH key for you..."
	ssh-keygen -t rsa

	echo "Please add this public key to Github \n"
	echo "https://github.com/account/ssh \n"
	echo "Opening the link now \n"
	sleep 2
	open "https://github.com/account/ssh"a
	read -p "Press [Enter] key after this..."
	# Need to write prompts for this section
	# echo "Git config"

	# git config --global user.name "Farman Pirzada"
	# git config --global user.email farman.pirz@gmail.com
}

xcode_installer_setup() {
	echo "Installing xcode"
	xcode-select --install
}
# Check for Homebrew,
# Install if we don't have it

homebrew_setup() {
	if test ! $(which brew); then
	  echo "Installing homebrew..."
	  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

	# Update homebrew recipes
	echo "Updating homebrew..."
	brew update

	echo "Cleaning up brew"
	brew cleanup

	echo "Installing homebrew cask"
	brew install cask

go_setup() {
	echo "Installing GoLang"
	brew install go
}

java_setup() {
	echo "Installing Java 1.8"
	brew cask install homebrew/cask-versions/adoptopenjdk8
}

net_setup() {
	echo "Installinig .NET"
	brew cask install dotnet dotnet-sdk
	# For installing older version
	brew tap isen-ng/dotnet-sdk-versions
	brew cask install dotnet-sdk-2.2.100
}

nvm_setup() {
	echo "Installing NVM"
	brew install nvm
	#Settings nvm
	mkdir ~/.nvm
}

rbenv_setup() {
	echo "Installing rbenv"
	brew install rbenv
}

iterm2_setup() {
	echo "Installing iTerm2"
	brew cask install iterm2
}

zsh_setup() {
	#Install Zsh & Oh My Zsh
	echo "Installing Oh My ZSH..."
	curl -L http://install.ohmyz.sh | sh

	echo "Setting up Oh My Zsh theme..."
	cd  /Users/bradparbs/.oh-my-zsh/themes
	curl https://gist.githubusercontent.com/bradp/a52fffd9cad1cd51edb7/raw/cb46de8e4c77beb7fad38c81dbddf531d9875c78/brad-muse.zsh-theme > brad-muse.zsh-theme

	echo "Setting up Zsh plugins..."
	cd ~/.oh-my-zsh/custom/plugins
	git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

	echo "Setting ZSH as shell..."
	chsh -s /bin/zsh
}

applications_setup() {
# @todo: download necessary Apps
# apps=(
#   diffmerge
#   dropbox
#   filezilla
#   firefox
#   google-chrome
#   harvest
#   private-internet-access
#   razer-synapse
#   sourcetree
#   steam
#   spotify
#   vagrant
#   iterm2
#   sublime-text2
#   textexpander
#   virtualbox
#   mailbox
#   vlc
#   transmission
#   zoomus
#   sequel-pro
#   chromecast
#   qlmarkdown
#   qlstephen
#   suspicious-package
# )
}

homebrew_setup
developer_utilities_setup
browser_install_setup
git_setup
github_setup
xcode_installer_setup
# DEVELOPMENT ENVIRONMENT SETUP
echo "Installing appropriate development tools environment"
go_setup
java_setup
net_setup
nvm_setup
rbenv_setup
iterm2_setup
zsh_setup
echo "Done!"
