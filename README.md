# dotfiles

##### Dotfiles are used to customize your system and automate installation. The “dotfiles” name is derived from the configuration files in Unix-like systems that start with a dot
---
## Installation

- clone repo
  
        git@github.com:jrivax/dotfiles.git

- launch install.sh

        bash install.sh

---
 ## Sections

 ### Brew Bundle ( Brewfile )

 https://gist.github.com/ChristopherA/a579274536aab36ea9966f301ff14f3f

 *A key feature of Brew is its ability to set up your Mac to a known configuration. It does this a feature called Bundle that uses Brewfiles. As doing development, or experimenting with new apps can break your system, I can easily restore back to a known configuration, both on my primary Macs, but also in VMware Fusion instances where I do more testing, including testing on old versions of MacOS and new beta versions of MacOS.*

 file
        Brewfile

 In this file, we usually find the following commands:

- `tap` a Git repository of Formulae and/or commands
- `brew` regular Homebrew command-line apps
- `mas` Mac App Store apps
- `cask` apps distributed as binaries       

### Config files

files with the config I usually use

        .zshrc
        .p10k.zsh
        .npmrc
        .gitconfig

file with MacOS config

        .macos