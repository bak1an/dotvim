## dotvim

### Single file, drop in vim configuration for remote locations.

Get a slightly fancier vim when working on a remote server.

See `.vimrc` itself  for details of what it has, `"the keys` section for useful keybinds.

#### Requirements

- `vim`
- `git`
- (optional) some `ctags` implementation, `universal-ctags` recommended

#### Install

```bash
curl -fLo ~/.vimrc https://raw.githubusercontent.com/bak1an/dotvim/refs/heads/master/.vimrc
```

or using git

```bash
git clone git@github.com:bak1an/dotvim.git ~/.dotvim && ln -s ~/.dotvim/.vimrc ~/.vimrc
```

It will install plugins upon first start into `~/.vim/plugged`.

You can also install plugins after downloading .vimrc with:

```bash
vim -es -u ~/.vimrc -i NONE -c "PlugInstall" -c "qa"
```

#### Get colors to display fine in tmux

```bash
echo 'set -g default-terminal "xterm-256color"' >> ~/.tmux.conf
```

#### Better vim in a dev container

```Dockerfile
RUN curl -fLo ~/.vimrc https://raw.githubusercontent.com/bak1an/dotvim/refs/heads/master/.vimrc
RUN vim -es -u ~/.vimrc -i NONE -c "PlugInstall" -c "qa" || exit 0
ENV TERM=xterm-256color
RUN echo 'set -g default-terminal "xterm-256color"' >> ~/.tmux.conf
```
