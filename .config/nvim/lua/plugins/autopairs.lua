return {
  'windwp/nvim-autopairs',
  -- Optional dependency
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    local npairs = require 'nvim-autopairs'
    local Rule = require 'nvim-autopairs.rule'
    npairs.setup { check_ts = true }

    local ts_conds = require 'nvim-autopairs.ts-conds'
    npairs.add_rule(Rule('|', '|', 'zig'):with_pair(ts_conds.is_ts_node { 'WhileStatement', 'IfStatement' }))

    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp = require 'cmp'
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
