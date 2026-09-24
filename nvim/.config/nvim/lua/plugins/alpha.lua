return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      [[                                             ]],
      [[      ████ ██████           █████      ██]],
      [[     ███████████             █████ ]],
      [[     █████████ ███████████████████ ███   ███████████]],
      [[    █████████  ███    █████████████ █████ ██████████████]],
      [[   █████████ ██████████ █████████ █████ █████ ████ █████]],
      [[ ███████████ ███    ███ █████████ █████ █████ ████ █████]],
      [[██████  █████████████████████ ████ █████ █████ ████ ██████]],
    }

    dashboard.section.buttons.val = {
      dashboard.button("e", "\u{f15b}  New file", "<cmd>ene<CR>"),
      dashboard.button("f", "\u{f002}  Find file", "<cmd>Telescope find_files<CR>"),
      dashboard.button("r", "\u{f1da}  Recent files", "<cmd>Telescope oldfiles<CR>"),
      dashboard.button("g", "\u{f15c}  Find text", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("c", "\u{f013}  Config", "<cmd>lua require('telescope.builtin').find_files({ cwd = '~/dotfiles', hidden = true, file_ignore_patterns = { '^%.git/' } })<CR>"),
      dashboard.button("l", "\u{f1b2}  Lazy", "<cmd>Lazy<CR>"),
      dashboard.button("q", "\u{f08b}  Quit", "<cmd>qa<CR>"),
    }

    dashboard.section.footer.opts.hl = "Comment"

    -- vertically center: the top padding is whatever is left after the content, split evenly
    local top = dashboard.config.layout[1]
    local function center_vertically()
      -- header, 2 lines of padding, buttons (each followed by a blank line), footer
      local content = #dashboard.section.header.val + 2 + #dashboard.section.buttons.val * 2 + 1
      top.val = math.max(0, math.floor((vim.fn.winheight(0) - content) / 2))
    end
    center_vertically()

    alpha.setup(dashboard.config)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      once = true,
      callback = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime + 0.5)
        dashboard.section.footer.val = string.format("%d/%d plugins loaded in %d ms", stats.loaded, stats.count, ms)
        pcall(vim.cmd.AlphaRedraw)
      end,
    })

    -- hide the "~" end-of-buffer markers below the dashboard, and bring them back once a file is opened
    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      callback = function() vim.opt.fillchars:append({ eob = " " }) end,
    })
    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaClosed",
      callback = function() vim.opt.fillchars:remove("eob") end,
    })

    vim.api.nvim_create_autocmd("VimResized", {
      callback = function()
        if vim.bo.filetype == "alpha" then
          center_vertically()
          pcall(vim.cmd.AlphaRedraw)
        end
      end,
    })
  end,
}
