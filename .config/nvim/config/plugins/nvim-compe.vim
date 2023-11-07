lua <<EOF
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'never';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = {kind = " "};
    buffer = {kind = " "};
    calc = {kind = " "};
    nvim_lsp = {kind = " "};
    nvim_lua = {kind = " "};
    vsnip = {kind = "  "};
    emoji = {kind = "ﲃ ", filetypes={"markdown", "text"}};
    --spell = {kind = " "};
  };
}
vim.o.completeopt = "menuone,noselect"
EOF

inoremap <silent><expr> <C-e> compe#close('<C-e>')
inoremap <silent><expr> <C-n> compe#complete()
inoremap <silent><expr> <C-p> compe#complete()
