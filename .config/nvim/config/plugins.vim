if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sleuth'
" if !exists('g:started_by_firenvim')
    " Plug 'vim-airline/vim-airline'
    " Plug 'vim-airline/vim-airline-themes'
" endif
Plug 'Konfekt/vim-CtrlXA'
" Plug 'jiangmiao/auto-pairs'
Plug 'windwp/nvim-autopairs'
Plug 'godlygeek/tabular'
Plug 'crusoexia/vim-monokai'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'onsails/lspkind-nvim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'kevinhwang91/nvim-bqf'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'antoinemadec/coc-fzf'
" Plug 'alvan/vim-closetag', { 'for': ['html', 'javascript', 'javascript.jsx', 'typescript.tsx'] }
Plug 'Yggdroot/indentLine'
Plug 'chaoren/vim-wordmotion'
Plug 'airblade/vim-rooter'
Plug 'plasticboy/vim-markdown'
Plug 'kovetskiy/sxhkd-vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
" Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'vifm/vifm.vim'
Plug 'vimwiki/vimwiki'
Plug 'jbyuki/instant.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-ts-autotag'
Plug 'ziglang/zig.vim'
Plug 'stevearc/vim-arduino'
Plug 'kmonad/kmonad-vim'
Plug 'elzr/vim-json'
Plug 'elixir-editors/vim-elixir'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'sevko/vim-nand2tetris-syntax'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neovimhaskell/haskell-vim'
Plug 'LnL7/vim-nix'
Plug 'vmchale/dhall-vim'
" Plug 'monkoose/fzf-hoogle.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'airblade/vim-gitgutter'
" Plug 'mhinz/vim-signify'
" Plug 'honza/vim-snippets'
Plug 'rafamadriz/friendly-snippets'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'unblevable/quick-scope'
" Plug 'nacitar/a.vim'
Plug 'liuchengxu/vim-which-key'
Plug 'michaeljsmith/vim-indent-object'
Plug 'ryanoasis/vim-devicons'
call plug#end()


