return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text"
    },
    config = function ()
        local dap, dapui, daptext = require("dap"), require("dapui"), require("nvim-dap-virtual-text")

        dapui.setup();
        daptext.setup();

        dap.adapters.coreclr = {
            type = "executable",
            command = "C:/Users/jamey/AppData/Local/netcoredbg/300-1018/netcoredbg",
            args = {"--interpreter=vscode"}
        }

        dap.configurations.cs = {
            {
                type = "coreclr",
                name = "launch",
                request = "launch",
                program = function()
                    local cwd = vim.fn.getcwd()
                    cwd = cwd:gsub("\\", "/")
                    local lastSlashIndex = cwd:find("/[^/]*$")
                    local maybeProject = cwd:sub(lastSlashIndex + 1, -1)
                    return vim.fn.input("", vim.fn.getcwd() .. "/bin/Debug/net8.0/" .. maybeProject .. ".dll", "file")
                end
            }
        }

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

        vim.keymap.set("n", "<leader>dt", function() require("dapui").toggle() end)
        vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end)
        vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end)
        vim.keymap.set("n", "<leader>do", function() require("dap").step_over() end)
        vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end)
    end
}
