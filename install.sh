#!bin/bash
# By FJRivax with love

echo "Starting installation and configuration process, let's do magic :)"
# Dotfiles directory
dir=~/dotfiles

# Create workspace
echo "create workspace"
cd ~
if ! -d ~/workspace; then
    mkdir ~/workspace
fi

echo "SECTION -> Homebrew ( package management )"
# Install Homebrew ( package management )
if ! hash brew 2>/dev/null; then
    echo "Installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Force to reinstall core due to packages formulas not found when brew search <package>
    rm -rf "/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core"
    echo "Launch brew tap core"
    brew tap homebrew/core
fi
echo "Installing Homebrew packages"
if hash brew 2>/dev/null; then
    echo "Launch brew bundle"
    brew bundle install --file=~/dotfiles/Brewfile
    continue
else
    echo "Nor git nor brew"    
fi    
echo "SECTION -> Dotfiles"
# Clone our repo with dotfiles
if  [ ! -d $dir ] && hash git 2>/dev/null; then
    echo "Installing dotfiles repo"
    cd ~
    echo "Clonning dotfiles repo"
    git clone https://github.com/jrivax/dotfiles.git
fi    
# Open Hammerspoon
# open -a Hammerspoon

# Install oh my zsh
echo "SECTION -> zsh"
if ! hash /bin/bash 2>/dev/null; then
    echo "installing zsh"
    cd ~
    /bin/bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi    
echo "SECTION -> Powerlevel10k"
# Install Powerlevel10k theme
if hash git 2>/dev/null; then
    echo "installing Powerlevel10k"
    cd ~
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi    

echo "SECTION -> zsh-autosuggestions"
# Install zsh-autosuggestions
if hash git 2>/dev/null; then
    echo "Installing zsh-autosuggestions"
    cd ~
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
echo "SECTION -> nerd fonts"
# Install zsh-autosuggestions
if hash git 2>/dev/null; then
    echo "Installing nerd fonts"
    cd ~/workspace
    git clone --depth=1 https://github.com/romkatv/nerd-fonts.git
    cd nerd-fonts
    ./build 'Meslo/S/*'
fi
# Install LTS Node
if hash nvm 2>/dev/null; then
    echo "install lts versions"
    nvm install "lts/*"
fi        

# Configure profile

files=".p10k.zsh .zshrc .gitconfig .npmrc"

# Create a dir to move the configuration files there
if [ ! -d $dir ]; then
    mkdir $dir
fi   

for file in $files; do
    echo "Creating symlink to $file in home directory."
    -e ~/$file && rm ~/$file
    ln -s $dir/$file ~/$file
    source $file
done

# Change MacOS configuration
source ~/dotfiles/.macos

# Create private-profile
cd ~
touch .private-profile
echo "create temporal file"
if [ ! -d ~/tmp ]; then
    mkdir ~/tmp
fi
