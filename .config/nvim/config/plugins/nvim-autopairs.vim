lua <<EOF
local remap = vim.api.nvim_set_keymap
local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')

-- skip it, if you use another global object
_G.MUtils= {}

npairs.setup({
    check_ts = true,
    map_cr = true,
})

require('nvim-treesitter.configs').setup {
    autopairs = {enable = true}
}

vim.g.completion_confirm_key = ""
MUtils.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"](npairs.esc("<cr>"))
    else
      return npairs.esc("<cr>")
    end
  else
    return npairs.autopairs_cr()
  end
end

remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})

npairs.add_rules({
  Rule("|", "|", "zig")
})

npairs.add_rules({
  Rule("$", "$", "vimwiki")
})

npairs.get_rule('"')[1]
 :with_pair(function()
    if vim.bo.filetype == 'vim' then
       return false
   end
end)
EOF
