return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { 
			"nvim-lua/plenary.nvim",
			"folke/which-key.nvim"
		},
    config = function()
      local builtin = require("telescope.builtin")
			local which_key = require("which-key")

      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

			-- Регистрация подсказок для Telescope с использованием which-key
      which_key.register({
        ["<leader>"] = {
          f = {
            name = "Telescope",
            f = { "<cmd>lua require('telescope.builtin').find_files()<CR>", "Find Files" },
            g = { "<cmd>lua require('telescope.builtin').live_grep()<CR>", "Live Grep" },
            b = { "<cmd>lua require('telescope.builtin').buffers()<CR>", "Buffers" },
            h = { "<cmd>lua require('telescope.builtin').help_tags()<CR>", "Help Tags" },
          }
        }
      })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
