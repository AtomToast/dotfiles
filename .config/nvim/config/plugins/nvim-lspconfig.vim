lua <<EOF
local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.zls.setup {
  capabilities = capabilities,
}

-- lspconfig.vimls.setup{}

lspconfig.clangd.setup{
  capabilities = capabilities,
}
-- lspconfig.ccls.setup{}

lspconfig.gopls.setup{
  capabilities = capabilities,
}

lspconfig.pyright.setup{
  capabilities = capabilities,
}

lspconfig.rust_analyzer.setup{
  capabilities = capabilities,
}

lspconfig.efm.setup{
  init_options = {documentFormatting = true},
  root_dir = require("lspconfig").util.root_pattern{".git/", "."},
  filetypes = {
    "lua",
    "python",
    "sh",
    "javascriptreact",
    "javascript",
    "typescript",
    "typescriptreact",
    "html",
    "css",
    "json",
    "yaml",
    "markdown",
  },
  settings = {
    rootMarkers = {".git/"},
    languages = {
      vim = {
        {
          lintCommand = "vint -",
          lintSource = "vint",
          lintStdin = true,
          lintFormats = {"%f:%l:%c: %m"},
        },
      },
      sh = {
        {
          formatCommand = "shfmt -i 4 -bn -sr -p -ci",
          formatStdin = true,
          lintCommand = "shellcheck -f gcc -x",
          lintSource = "shellcheck",
          lintFormats = {
            "%f:%l:%c: %trror: %m",
            "%f:%l:%c: %tarning: %m",
            "%f:%l:%c: %tote: %m",
          },
        },
      },
      lua = {{formatCommand = "lua-format -i", formatStdin = true}},
      html = {
        {formatCommand = "prettier ${--tab-width:tabWidth} --parser html"},
      },
      css = {
        {formatCommand = "prettier ${--tab-width:tabWidth} --parser css"},
      },
      json = {
        {
          formatCommand = "prettier ${--tab-width:tabWidth} --parser json",
          lintCommand = "jq .",
          lintStdin = true,
        },
      },
      python = {
        {formatCommand = "autopep8 -", formatStdin = true},
        -- {formatCommand = "isort --stdout --profile black -", formatStdin = true},
      },
      yaml = {{formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true}},
      markdown = {{formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true}},
      javascript = {{formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true}},
      typescript = {{formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true}},
      javascriptreact = {{formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true}},
      typescriptreact = {{formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true}},
    }
  }
}

local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
lspconfig.sumneko_lua.setup {
  cmd = {"lua-language-server", "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

lspconfig.cssls.setup {
  cmd = {"css-languageserver"},
  capabilities = capabilities,
}

lspconfig.texlab.setup{}

lspconfig.html.setup {
  cmd = {"vscode-html-languageserver"},
  capabilities = capabilities,
  filetypes = { "html", "htmldjango" },
}

lspconfig.tsserver.setup{
  capabilities = capabilities,
}

lspconfig.jsonls.setup {
  cmd = {"vscode-json-languageserver", "--stdio"},
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  }
}

lspconfig.yamlls.setup{}

------------------------------------------------------------------------

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    underline = true,
  }
)
EOF

" configure diagnostic signs
set signcolumn=auto:4
sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticSignError
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticSignWarn
sign define DiagnosticSignInformation text= texthl=DiagnosticSignInformation linehl= numhl=DiagnosticSignInformation
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticSignHint
highlight DiagnosticSignError guifg=#e73c50 guibg=#2D2E27 ctermfg=1 ctermbg=237
highlight DiagnosticSignWarn guifg=#e7c547 guibg=#2D2E27 ctermfg=1 ctermbg=237
highlight DiagnosticSignInformation guifg=#e6db74 guibg=#2D2E27 ctermfg=1 ctermbg=237
highlight DiagnosticSignHint guifg=#66d9ef guibg=#2D2E27 ctermfg=1 ctermbg=237



function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    lua vim.lsp.buf.hover()
  endif
endfunction

nnoremap <silent> K     <cmd>call <SID>show_documentation()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> go    <cmd>lua vim.diagnostic.set_loclist()<CR>
nnoremap <silent> ]c <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> [c <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> <leader>f    <cmd>lua vim.lsp.buf.formatting()<CR>
vnoremap <silent> <leader>f    <cmd>lua vim.lsp.buf.range_formatting()<CR>
nnoremap <silent> <leader>rn   <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>a    <cmd>ClangdSwitchSourceHeader<CR>
nnoremap <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
inoremap <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>

" recommended by coc
set nobackup
set nowritebackup

" show diagnostics popup on hover
set updatetime=100
" autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

nnoremap gK <cmd>lua vim.diagnostic.open_float({scope="cursor"})<CR>

" automatically format on save
autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
