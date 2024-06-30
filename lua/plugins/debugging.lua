return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap-python",
			"folke/which-key.nvim" -- Добавляем which-key.nvim
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local dap_python = require("dap-python")
			local which_key = require("which-key")

			-- Function to automatically detect virtual environment
			local function detect_venv()
				local venv = os.getenv("VIRTUAL_ENV")
				if venv then
					return venv .. "/bin/python"
				end

				local cwd = vim.fn.getcwd()
				if vim.fn.filereadable(cwd .. "/venv/bin/python") == 1 then
					return cwd .. "/venv/bin/python"
				elseif vim.fn.filereadable(cwd .. "/.venv/bin/python") == 1 then
					return cwd .. "/.venv/bin/python"
				else
					return "python"
				end
			end

			-- Setup dap-python with the detected virtual environment
			dap_python.setup(detect_venv())

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			-- Key mappings for debugging
			vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Continue" })
			vim.keymap.set("n", "<Leader>do", dap.step_over, { desc = "Step Over" })
			vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "Step Into" })
			vim.keymap.set("n", "<Leader>du", dap.step_out, { desc = "Step Out" })
			vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "Open REPL" })
			vim.keymap.set("n", "<Leader>dl", dap.run_last, { desc = "Run Last" })
			vim.keymap.set("n", "<Leader>ds", dap.terminate, { desc = "Stop Debugging" })

			-- Additional key mappings for dap-ui
			vim.keymap.set("n", "<Leader>de", dapui.eval, { desc = "Evaluate" })
			vim.keymap.set("v", "<Leader>de", dapui.eval, { desc = "Evaluate" })

			-- Key mapping to run the current file
			vim.keymap.set("n", "<Leader>df", function()
				local file = vim.fn.expand("%")
				vim.cmd("!python " .. file)
			end, { desc = "Run Current File" })

			-- Setup which-key to show key bindings
			which_key.setup {}

			-- Register key mappings with which-key
			which_key.register({
				["<Leader>d"] = {
					name = "Debug",
					t = "Toggle Breakpoint",
					c = "Continue",
					o = "Step Over",
					i = "Step Into",
					u = "Step Out",
					r = "Open REPL",
					l = "Run Last",
					s = "Stop Debugging",
					e = "Evaluate",
					f = "Run Current File",
				}
			})
		end,
	}
}
