# neovim-configuration

### Clone the config into Neovim config directory

**Windows (PowerShell 7+)**
```shell
git clone https://github.com/Critiek/neovim-configuration $env:LOCALAPPDATA/nvim
```

**Linux/MacOS**
```shell
git clone https://github.com/Critiek/neovim-configuration ~/.config/nvim
```

### One Command to install (DELETES OLD NEOVIM CONFIG!!!)

**Windows (PowerShell 7+)**
```shell
rm -force -r $env:USERPROFILE\AppData\Local\nvim\ && rm -force -r $env:USERPROFILE\AppData\Local\nvim-data\ && git clone https://github.com/Critiek/neovim-configuration $env:LOCALAPPDATA/nvim
```

**Linux/MacOS**
```shell
sudo rm -rf ~/.config/nvim && sudo rm -rf ~/.local/share/nvim && git clone https://github.com/Critiek/neovim-configuration ~/.config/nvim
```
