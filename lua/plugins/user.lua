-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      label = {
        style = "overlay",
      },
    },
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<leader>sd", mode = { "n", "x", "o" }, function()
      require("flash").jump({
        matcher = function(win)
          ---@param diag Diagnostic
          return vim.tbl_map(function(diag)
            return {
              pos = { diag.lnum + 1, diag.col },
              end_pos = { diag.end_lnum + 1, diag.end_col - 1 },
            }
          end, vim.diagnostic.get(vim.api.nvim_win_get_buf(win)))
        end,
        action = function(match, state)
          vim.api.nvim_win_call(match.win, function()
            vim.api.nvim_win_set_cursor(match.win, match.pos)
            vim.diagnostic.open_float()
          end)
          state:restore()
        end,
      })
    end, desc = "Toggle Flash Search" },
  },
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>zx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>zX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>zs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>zl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>zL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>zQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    opts = {
      -- messages = {
      --   enabled = false,
      -- },
      -- cmdline = {
      --   enabled = false,
      -- },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
  },
}
-- == Examples of Adding Plugins ==

-- "andweeb/presence.nvim",
-- {
--   "ray-x/lsp_signature.nvim",
--   event = "BufRead",
--   config = function() require("lsp_signature").setup() end,
-- },
--
-- -- == Examples of Overriding Plugins ==
--
-- -- customize alpha options
-- {
--   "goolord/alpha-nvim",
--   opts = function(_, opts)
--     -- customize the dashboard header
--     opts.section.header.val = {
--       " █████  ███████ ████████ ██████   ██████",
--       "██   ██ ██         ██    ██   ██ ██    ██",
--       "███████ ███████    ██    ██████  ██    ██",
--       "██   ██      ██    ██    ██   ██ ██    ██",
--       "██   ██ ███████    ██    ██   ██  ██████",
--       " ",
--       "    ███    ██ ██    ██ ██ ███    ███",
--       "    ████   ██ ██    ██ ██ ████  ████",
--       "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
--       "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
--       "    ██   ████   ████   ██ ██      ██",
--     }
--     return opts
--   end,
-- },
--
-- -- You can disable default plugins as follows:
-- { "max397574/better-escape.nvim", enabled = false },
--
-- -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
-- {
--   "L3MON4D3/LuaSnip",
--   config = function(plugin, opts)
--     require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
--     -- add more custom luasnip configuration such as filetype extend or custom snippets
--     local luasnip = require "luasnip"
--     luasnip.filetype_extend("javascript", { "javascriptreact" })
--   end,
-- },
--
-- {
--   "windwp/nvim-autopairs",
--   config = function(plugin, opts)
--     require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
--     -- add more custom autopairs configuration such as custom rules
--     local npairs = require "nvim-autopairs"
--     local Rule = require "nvim-autopairs.rule"
--     local cond = require "nvim-autopairs.conds"
--     npairs.add_rules(
--       {
--         Rule("$", "$", { "tex", "latex" })
--           -- don't add a pair if the next character is %
--           :with_pair(cond.not_after_regex "%%")
--           -- don't add a pair if  the previous character is xxx
--           :with_pair(
--             cond.not_before_regex("xxx", 3)
--           )
--           -- don't move right when repeat character
--           :with_move(cond.none())
--           -- don't delete if the next character is xx
--           :with_del(cond.not_after_regex "xx")
--           -- disable adding a newline when you press <cr>
--           :with_cr(cond.none()),
--       },
--       -- disable for .vim files, but it work for another filetypes
--       Rule("a", "a", "-vim")
--     )
--   end,
-- },
