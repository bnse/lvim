# INSTALL

- [lunarvim installation](https://www.lunarvim.org/docs/installation)

## install neovim 0.8.x

```bash
brew install neovim
```

## install lunarvim

```bash
LV_BRANCH='release-1.2/neovim-0.8' bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/fc6873809934917b470bff1b072171879899a36b/utils/installer/install.sh)
```

## set priviate config

```bash
cd ~/.config/ && gh repo clone github.com/bnse/lvim
```

```lvim
:PackerInstall
:PackerUpdate
:Mason     move cursor on the select, and press `u` to update 
:TSUpdate 
```

Or:

```lvim
:LvimCacheReset
:LvimUpdate
```

- `Packer`: Package Manager.
- `Mason`: Plugin Manager.
- `TSInstall`: more treesitter parsers.

```~/.config/lvim/config.lua
lvim.plugins = {
  {
    "ellisonleao/gruvbox.nvim"
  },
  -- { "marko-cerovac/material.nvim" },
  -- { "folke/tokyonight.nvim" },
  -- { "sainnhe/sonokai" },

  {
    "tpope/vim-surround",
    -- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
    -- setup = function()
    --   vim.o.timeoutlen = 500
    -- end
  },
  {
    "mattn/vim-gist",
    event = "BufRead",
    requires = "mattn/webapi-vim",
  },
  {
    'nkrkv/nvim-treesitter-rescript',
  },
  {
    'bantana/vim-present',
  },
  {
    'christoomey/vim-tmux-navigator',
  },
}
```

## Usage on lvim

- shortcut

```config.lua
lvim.leader = "space"
```

- colorscheme

```config.lua
lvim.colorscheme = "gruvbox"
```

```vim
:PackerInstall
:PackerClean
:PackerUpdate


:Mason
:MasonInstall gopls
:MasonInstall rescript-lsp

:TSInstall go
:TSInstall rescript
:TSUpdate
```
