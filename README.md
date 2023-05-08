# INSTALL

- [lunarvim installation](https://www.lunarvim.org/docs/installation)

## install neovim 0.9.x

```bash
brew install neovim
```

## install lunarvim

```bash
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
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


## brew install related tools

Lua formater:

    brew install stylua

Grammer translater:

    brew install ltex-ls

Lazy git tools:

    brew install lazygit


