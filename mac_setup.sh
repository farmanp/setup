#!/bin/bash

# Overview of this script is running an automated installation workflow that goes step by step below:
# 1. Homebrew
# 2. Developer Utilities
# 3. Browsers
# 4. Git
# 5. GitHub
# 6. XCode
# 7. Go
# 8. Java
# 9. .Net
# 10. nvm
# 11. rbenv
# 12. iTerm 2
# 13. ZSH
# 14. asdf
# 15. Docker setup
# 16. Kubernetes setup
# 17. Python setup

# Check for macOS,
# Exit if not macOS
if [[ ! "$OSTYPE" == "darwin"* ]]; then
	echo "You are currently on $OSTYPE"
	echo "You need to be on macOS to proceed with this script"
	exit 1
fi

# Update homebrew recipes
homebrew_setup() {
    if ! command -v brew &> /dev/null
    then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Homebrew already installed. Skipping Homebrew installation."
    fi
    
    echo "Updating Homebrew..."
    brew update && brew upgrade
    
    echo "Cleaning up Homebrew..."
    brew cleanup
}


# Install developer utilities
developer_utilities_setup() {
    # Check if tree is installed
    if ! command -v tree &> /dev/null
    then
        echo "Installing tree..."
        brew install tree
    else
        echo "tree already installed. Skipping installation."
    fi
    
    # Check if wget is installed
    if ! command -v wget &> /dev/null
    then
        echo "Installing wget..."
        brew install wget
    else
        echo "wget already installed. Skipping installation."
    fi
    
    # Check if trash is installed
    if ! command -v trash &> /dev/null
    then
        echo "Installing trash..."
        brew install trash
    else
        echo "trash already installed. Skipping installation."
    fi
    
    # Check if mackup is installed
    if ! command -v mackup &> /dev/null
    then
        echo "Installing mackup..."
        brew install mackup
    else
        echo "mackup already installed. Skipping installation."
    fi
    
    # Check if node is installed
    if ! command -v node &> /dev/null
    then
        echo "Installing Node.js..."
        brew install node
    else
        echo "Node.js already installed. Skipping installation."
    fi
}

# Install browsers and other macOS applications
browser_install_setup() {
	echo "Installing browsers and other macOS applications..."
	
	# Install Google Chrome
	if [ ! -d "/Applications/Google Chrome.app" ]; then
		brew install --cask google-chrome
	else
		echo "Google Chrome is already installed."
	fi
	
	# Install Firefox
	if [ ! -d "/Applications/Firefox.app" ]; then
		brew install --cask firefox
	else
		echo "Firefox is already installed."
	fi
}


# Install Git and git utilities
git_setup() {
    # Check if Git is installed
    if ! command -v git &> /dev/null
    then
        echo "Installing Git..."
        brew install git
    else
        echo "Git already installed. Skipping installation."
    fi
    
    # Check if git-extras is installed
    if ! brew list git-extras &> /dev/null
    then
        echo "Installing git-extras..."
        brew install git-extras
    else
        echo "git-extras already installed. Skipping installation."
    fi
    
    # Check if legit is installed
    if ! brew list legit &> /dev/null
    then
        echo "Installing legit..."
        brew install legit
    else
        echo "legit already installed. Skipping installation."
    fi
    
    # Check if git-flow is installed
    if ! brew list git-flow &> /dev/null
    then
        echo "Installing git-flow..."
        brew install git-flow
    else
        echo "git-flow already installed. Skipping installation."
    fi
}

# Set up GitHub
github_setup() {
    # Check if SSH key already exists
    if [ -f ~/.ssh/id_rsa.pub ]
    then
        echo "SSH key already exists. Skipping generation."
    else
        echo "Generating an SSH key..."
        ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
    fi

    # Check if the SSH key is added to the Github account
    if ssh -T git@github.com &> /dev/null
    then
        echo "SSH key already added to the Github account. Skipping step."
    else
        # Ask the user to add the public key to their Github account
        echo "Please add this public key to Github:"
        echo "https://github.com/settings/ssh/new"
        echo "Press any key to continue after adding the key..."
        read -n 1 -s
    fi

    # Configure Git user name and email
    git config --global user.name "Your Name"
    git config --global user.email "your_email@example.com"
}

# Install Xcode CLI tools
xcode_installer_setup() {
    # Check if Xcode command-line tools are already installed
    if xcode-select -p &> /dev/null
    then
        echo "Xcode command-line tools are already installed. Skipping installation."
    else
        # Install Xcode command-line tools
        echo "Installing Xcode command-line tools..."
        xcode-select --install
    fi
}

# Install Go
go_setup() {
    # Check if Go is already installed
    if go version &> /dev/null
    then
        echo "Go is already installed. Skipping installation."
    else
        # Install Go
        echo "Installing Go..."
        brew install go
    fi
}

# Install Java
java_setup() {
    # Check if Java is already installed
    if java -version &> /dev/null
    then
        echo "Java is already installed. Skipping installation."
    else
        # Install Java
        echo "Installing Java..."
        brew install --cask adoptopenjdk8
    fi
}


# Install .NET
net_setup() {
    # Check if .NET is already installed
    if dotnet --version &> /dev/null
    then
        echo ".NET is already installed. Skipping installation."
    else
        # Install .NET
        echo "Installing .NET..."
        brew install --cask dotnet-sdk
    fi
}

# Install NVM
nvm_setup() {
    if [ -d "$HOME/.nvm" ]
    then
        echo "NVM is already installed. Skipping installation."
    else
        echo "Installing NVM..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
        mkdir ~/.nvm
    fi
}


# Install rbenv
rbenv_setup() {
    if rbenv -v &> /dev/null
    then
        echo "rbenv is already installed. Skipping installation."
    else
        echo "Installing rbenv..."
        brew install rbenv
    fi
}


# Install iTerm2
iterm2_setup() {
    if [ -d "/Applications/iTerm.app" ]
    then
        echo "iTerm2 is already installed. Skipping installation."
    else
        echo "Installing iTerm2..."
        brew install --cask iterm2
    fi
}

# Install ZSH and Oh My Zsh
zsh_setup() {
	if [ -d ~/.oh-my-zsh ]; then
		echo "Oh My Zsh is already installed."
		return 0
	fi
	
	echo "Installing Zsh and Oh My Zsh..."
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	
	echo "Setting up Oh My Zsh theme..."
	cd ~/.oh-my-zsh/themes
	curl -O https://raw.githubusercontent.com/dracula/zsh/master/dracula.zsh-theme
	sed -i "" "s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"dracula\"/g" ~/.zshrc
	
	echo "Setting up Zsh plugins..."
	cd ~/.oh-my-zsh/custom/plugins
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
	git clone https://github.com/zsh-users/zsh-autosuggestions.git
	
	echo "Setting Zsh as default shell..."
	chsh -s $(which zsh)
}


# Install asdf
asdf_setup() {
	echo "Checking if asdf is already installed..."
	if [ ! -x "$(command -v asdf)" ]; then
		echo "asdf not found. Installing asdf..."
		brew install asdf
	else
		echo "asdf already installed. Skipping..."
	fi
	
	echo "Adding asdf to shell..."
	if ! grep -qF "asdf.sh" ~/.zshrc; then
		echo -e "\n. $(brew --prefix asdf)/asdf.sh" >> ~/.zshrc
		echo -e "\n. $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash" >> ~/.zshrc
		source ~/.zshrc
	else
		echo "asdf already added to shell. Skipping..."
	fi
	
	echo "Checking asdf plugins..."
	asdf plugin add ruby
	asdf plugin add nodejs
	asdf plugin add java
	asdf plugin add dotnet-core
	asdf plugin add golang
	
	echo "Checking asdf versions..."
	if ! asdf list ruby | grep -qF "3.0.3"; then
		asdf install ruby 3.0.3
		asdf global ruby 3.0.3
	else
		echo "Ruby 3.0.3 already installed. Skipping..."
	fi
	
	if ! asdf list nodejs | grep -qF "16.13.1"; then
		asdf install nodejs 16.13.1
		asdf global nodejs 16.13.1
	else
		echo "Node.js 16.13.1 already installed. Skipping..."
	fi
	
	if ! asdf list java | grep -qF "adoptopenjdk-16.0.2+7"; then
		asdf install java adoptopenjdk-16.0.2+7
		asdf global java adoptopenjdk-16.0.2+7
	else
		echo "Java 16.0.2+7 already installed. Skipping..."
	fi
	
	if ! asdf list dotnet-core | grep -qF "6.0.100"; then
		asdf install dotnet-core 6.0.100
		asdf global dotnet-core 6.0.100
	else
		echo ".NET Core 6.0.100 already installed. Skipping..."
	fi
	
	if ! asdf list golang | grep -qF "1.17.6"; then
		asdf install golang 1.17.6
		asdf global golang 1.17.6
	else
		echo "Go 1.17.6 already installed. Skipping..."
	fi
	
	echo "asdf setup complete!"
}

package_manager_setup() {
	echo "Installing Homebrew packages..."
	
	brew_packages=(
		mas
		shellcheck
		yarn
		gradle
		maven
		ant
		pkg-config
		openssl
		cmake
		autoconf
		automake
		libtool
		libyaml
	)
	
	for package in "${brew_packages[@]}"
	do
		if brew list "$package" >/dev/null 2>&1; then
			echo "$package already installed"
		else
			echo "Installing $package..."
			brew install "$package"
		fi
	done
}

command_line_tools_setup() {
    echo "Installing command-line tools..."

    # Check if Homebrew packages are installed
    if brew list bash-completion >/dev/null 2>&1; then
        echo "bash-completion is already installed"
    else
        brew install bash-completion
    fi

    if brew list ffmpeg >/dev/null 2>&1; then
        echo "ffmpeg is already installed"
    else
        brew install ffmpeg
    fi

    if brew list htop >/dev/null 2>&1; then
        echo "htop is already installed"
    else
        brew install htop
    fi

    if brew list imagemagick >/dev/null 2>&1; then
        echo "imagemagick is already installed"
    else
        brew install imagemagick
    fi

    if brew list pv >/dev/null 2>&1; then
        echo "pv is already installed"
    else
        brew install pv
    fi

    if brew list the_silver_searcher >/dev/null 2>&1; then
        echo "the_silver_searcher is already installed"
    else
        brew install the_silver_searcher
    fi

    if brew list tldr >/dev/null 2>&1; then
        echo "tldr is already installed"
    else
        brew install tldr
    fi

    if brew list tmux >/dev/null 2>&1; then
        echo "tmux is already installed"
    else
        brew install tmux
    fi

    if brew list tree >/dev/null 2>&1; then
        echo "tree is already installed"
    else
        brew install tree
    fi

    if brew list watch >/dev/null 2>&1; then
        echo "watch is already installed"
    else
        brew install watch
    fi

    if brew list wget >/dev/null 2>&1; then
        echo "wget is already installed"
    else
        brew install wget
    fi
}

automation_scripts_setup() {
	echo "Installing automation scripts..."

	# Check if ansible is installed
	if ! command -v ansible &> /dev/null; then
	    echo "ansible not found, installing..."
	    brew install ansible
	else
	    echo "ansible is already installed"
	fi
	
	# Check if packer is installed
	if ! command -v packer &> /dev/null; then
	    echo "packer not found, installing..."
	    brew install packer
	else
	    echo "packer is already installed"
	fi
	
	# Check if terraform is installed
	if ! command -v terraform &> /dev/null; then
	    echo "terraform not found, installing..."
	    brew install terraform
	else
	    echo "terraform is already installed"
	fi
}

aliases_setup() {
    echo "Setting up aliases..."

    if ! grep -Fxq "alias ll='ls -l'" ~/.zshrc; then
        echo "alias ll='ls -l'" >> ~/.zshrc
    fi
    
    if ! grep -Fxq "alias la='ls -la'" ~/.zshrc; then
        echo "alias la='ls -la'" >> ~/.zshrc
    fi
}

comments_setup() {
	echo "Setting up comments..."
	
	echo "# My aliases" >> ~/.bashrc
}

dotfiles_backup_setup() {
	echo "Backing up dotfiles..."
	
	if [ ! -d ~/.dotfiles ]; then
		mkdir ~/.dotfiles
	fi
	
	cp -r ~/.bashrc ~/.dotfiles
	cp -r ~/.vimrc ~/.dotfiles
	cp -r ~/.zshrc ~/.dotfiles
}

# Docker setup
docker_setup() {
    echo "Checking for M1 chip Mac..."
    if [[ $(uname -m) == "arm64" ]]; then
        echo "M1 chip Mac detected. Installing Docker for Apple Silicon..."
        brew install --cask docker
    else
        echo "Standard Mac detected. Downloading Docker for Mac installer..."
        curl -fsSL https://download.docker.com/mac/stable/Docker.dmg -o docker.dmg
        
        echo "Mounting disk image..."
        hdiutil attach docker.dmg
        
        echo "Copying Docker app to Applications folder..."
        cp -R /Volumes/Docker/Docker.app /Applications
        
        echo "Unmounting disk image..."
        hdiutil detach /Volumes/Docker
        
        echo "Starting Docker..."
        open /Applications/Docker.app
        
        echo "Docker installation complete!"
    fi

    echo "Verifying Docker installation..."
    if docker --version >/dev/null 2>&1; then
        echo "Docker is installed and available."
    else
        echo "Error: Docker installation failed."
    fi
}

# Kubernetes setup
kubernetes_setup() {
	# Check if kubectl is already installed
	if command -v kubectl >/dev/null 2>&1; then
		echo "kubectl is already installed."
	else
		echo "Installing kubectl..."
		brew install kubectl
	fi

	# Check if minikube is already installed
	if command -v minikube >/dev/null 2>&1; then
		echo "minikube is already installed."
	else
		echo "Installing minikube..."
		brew install minikube
	fi
	
	# Check if virtualbox is already installed
	if brew cask list virtualbox >/dev/null 2>&1; then
		echo "VirtualBox is already installed."
	else
		echo "Installing VirtualBox..."
		brew install --cask virtualbox
	fi
	
	# Check if docker-machine is already installed
	if command -v docker-machine >/dev/null 2>&1; then
		echo "docker-machine is already installed."
	else
		echo "Installing docker-machine..."
		brew install docker-machine
	fi
	
	# Check if helm is already installed
	if command -v helm >/dev/null 2>&1; then
		echo "helm is already installed."
	else
		echo "Installing helm..."
		brew install helm
	fi
}

python_setup() {
	# Check if pyenv is installed
	if ! command -v pyenv > /dev/null 2>&1; then
		echo "pyenv is not installed. Please install pyenv and try again."
		return 1
	fi
	
	# Check if pyenv-virtualenv is installed
	if ! command -v pyenv-virtualenv > /dev/null 2>&1; then
		echo "pyenv-virtualenv is not installed. Please install pyenv-virtualenv and try again."
		return 1
	fi
	
	# Install latest version of Python
	pyenv install $(pyenv install --list | grep -v - | grep -v b | grep -v a | tail -1)
	
	# Create a virtualenv with the latest Python version
	pyenv virtualenv $(pyenv versions --bare | grep `pyenv version-name`) $(pyenv version-name)
	
	# Activate the virtualenv
	echo "eval \"\$(pyenv init --path)\"" >> ~/.zshrc
	echo "eval \"\$(pyenv virtualenv-init -)\"" >> ~/.zshrc
	echo "pyenv activate $(pyenv version-name)" >> ~/.zshrc
	
	# Reload the shell
	exec "$SHELL"
}


# Run installation functions
#!/bin/bash
installation_runner() {
	echo "Setting up your development environment..."

	# homebrew_setup
	# echo "Homebrew installation complete."

	developer_utilities_setup
	echo "Developer utilities installation complete."

	browser_install_setup
	echo "Browsers installation complete."

	git_setup
	echo "Git installation complete."

	github_setup
	echo "Github setup complete."

	xcode_installer_setup
	echo "Xcode CLI tools installation complete."

	go_setup
	echo "Go installation complete."

	# java_setup
	# echo "Java installation complete."

	net_setup
	echo ".NET installation complete."

	nvm_setup
	echo "NVM installation complete."

	rbenv_setup
	echo "rbenv installation complete."

	iterm2_setup
	echo "iTerm2 installation complete."

	zsh_setup
	echo "Zsh and Oh My Zsh installation complete."

	# asdf_setup
	echo "asdf installation complete."

	package_manager_setup
	echo "Package manager installation complete."

	command_line_tools_setup
	echo "Command-line tools installation complete."

	automation_scripts_setup
	echo "Automation scripts installation complete."

	aliases_setup
	echo "Aliases setup complete."

	comments_setup
	echo "Comments setup complete."

	dotfiles_backup_setup
	echo "Dotfiles backup complete."

	docker_setup
	echo "Docker setup complete!" 

	kubernetes_setup
	echo "Kubernetes setup complete!"

	python_setup
	echo "Python setup complete!"

	echo "Development environment setup complete!"
}

# Run installation functions
installation_runner
