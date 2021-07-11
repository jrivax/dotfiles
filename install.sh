#!bin/bash
# By FJRivax with love

echo "Starting installation and configuration process, let's do magic :)"
# Dotfiles directory
dir=~/dotfiles

# Create workspace
echo "create workspace"
cd ~
if [ ! -d ~/workspace ]; then
    mkdir ~/workspace
fi

echo "Homebrew ( package management )"
# Install Homebrew ( package management )
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if [ ! has brew 2>/dev/null ]; then
    echo "Installing Homebrew packages"
    brew bundle
fi    
# Clone our repo with dotfiles
if [ ! -d $dir && ! has git 2>/dev/null ]; then
    cd $dir
    echo "Clonning dotfiles repo"
    git clone https://github.com/jrivax/dotfiles.git
fi    
# Open Hammerspoon
# open -a Hammerspoon

# Install oh my zsh
if [ ! has sh 2>/dev/null ]; then
    cd ~
    /bin/bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi    

# Install Powerlevel10k theme
if [ ! has git 2>/dev/null ]; then
    cd ~
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi    

# Install zsh-autosuggestions
if [ ! has git 2>/dev/null ]; then
    cd ~
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# Install LTS Node
if [ ! has nvm 2>/dev/null ]; then
    nvm install "lts/*"
else
    echo "nvm has not been install"
fi        

# Configure profile

files=".p10k.zsh .zshrc .gitconfig"

# Create a dir to move the configuration files there
if [ ! -d $dir ]; then
    mkdir $dir
fi   

for file in $files; do
    echo "Creating symlink to $file in home directory."
    [ -e ~/$file ] && rm ~/$file
    ln -s $dir/$file ~/$file
    source $file
done

# Change MacOS configuration
source .macos

# Create private-profile
cd ~
touch .private-profile
echo "create temporal file"
if [ ! -d ~/tmp ]; then
    mkdir ~/tmp
fi
