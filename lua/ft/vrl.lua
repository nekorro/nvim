vim.filetype.add {
  extension = {
    vrl = "vrl",
  },
  -- filename = {
  --   ["Foofile"] = "fooscript",
  -- },
  pattern = {
    ["compose.ya?ml"] = "yaml.docker-compose",
  },
}

-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- ---@diagnostic disable-next-line: inject-field
-- parser_config.vrl = {
--   install_info = {
--     url = "https://github.com/belltoy/tree-sitter-vrl", -- local path or git repo
--     files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
--     -- -- optional entries:
--     branch = "main", -- default branch in case of git repo if different from master
--     generate_requires_npm = false, -- if stand-alone parser without npm dependencies
--     requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
--   },
--   -- filetype = "vrl", -- if filetype does not match the parser name
-- }

local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'
if not configs.vrl_lsp then
  configs.vrl_lsp = {
    default_config = {
      cmd = { 'vrl-lsp' },
      root_dir = lspconfig.util.root_pattern('.git'),
      filetypes = { 'vrl' },
    },
  }
end
lspconfig.vrl_lsp.setup {}

local ft = require('Comment.ft')
ft.vrl = {'#%s'}
