lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
  autopairs = {enable = true},
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99
