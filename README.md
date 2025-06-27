# My ZSH conf

## Install

```sh
git clone <this repo> ~/.config/zshrc.d
ln -s ~/.config/zshrc.d/.zshrc ~/ # or cp
```

## ssh hostname color

```sh
# set env variable example
echo PROMPT_HOSTNAME_COLOR=196 > ~/.config/zshrc-local.d/01-prompt-hostname-color.sh
```

## git support

1. Install Rustup <https://rustup.rs/>
   ```sh
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```
2. Install git-prompt 
   ```sh
   cargo install --git https://github.com/vitberget/git-prompt.git
   ```
