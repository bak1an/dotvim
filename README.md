## dotvim

### Single file drop in vim configuration for remote locations.

Getter a slightly fancier vim when working on a remote server.

#### Install

```bash
curl -fLo ~/.vimrc https://raw.githubusercontent.com/bak1an/dotvim/refs/heads/master/.vimrc
```

#### Install from git

```bash
git clone https://github.com/bak1an/dotvim.git ~/.dotvim && ln -s ~/.dotvim/.vimrc ~/.vimrc
```

It will install plugins upon first start into `~/.vim/plugged`.

You can also install plugins after downloading .vimrc with `vim -es -u vimrc -i NONE -c "PlugInstall" -c "qa"`.
