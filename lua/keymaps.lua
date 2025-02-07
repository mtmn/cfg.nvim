-- fzf-lua
vim.keymap.set("n", "<leader><leader>", "<cmd>lua require('fzf-lua').files()<CR>")
vim.keymap.set("n", "<leader>ff", "<cmd>lua require('fzf-lua').git_status()<CR>")
vim.keymap.set("n", "<leader>fh", "<cmd>lua require('fzf-lua').oldfiles()<CR>")
vim.keymap.set("n", "<leader>fb", "<cmd>lua require('fzf-lua').buffers()<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>lua require('fzf-lua').grep_project()<CR>")

-- Neogit
vim.keymap.set('n', '<leader>ng', '<cmd>Neogit<CR>')

-- oil.nvim
vim.keymap.set('n', '-', '<cmd>Oil<CR>')

-- git-blame.nvim
vim.keymap.set('n', '<leader>bc', '<cmd>GitBlameOpenCommitURL<CR>')

-- LSP
vim.keymap.set('n', '<leader>gg', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
vim.keymap.set('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('v', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>')
vim.keymap.set('n', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', '<leader>gl', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', '<leader>gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', '<leader>gn', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', '<leader>tr', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
vim.keymap.set('i', '<C-Space>', '<cmd>lua vim.lsp.buf.completion()<CR>')

-- Debugging
-- vim.keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
-- vim.keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
-- vim.keymap.set("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
-- vim.keymap.set("n", '<leader>br', "<cmd>lua require'dap'.clear_breakpoints()<cr>")
-- vim.keymap.set("n", "<leader>ba", "<cmd>lua require('fzf-lua').dap_breakpoints()<CR>")
-- vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
-- vim.keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
-- vim.keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>")
-- vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>")
-- vim.keymap.set("n", '<leader>dd', function() require('dap').disconnect(); require('dapui').close(); end)
-- vim.keymap.set("n", '<leader>dt', function() require('dap').terminate(); require('dapui').close(); end)
-- vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
-- vim.keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
-- vim.keymap.set("n", '<leader>di', function() require "dap.ui.widgets".hover() end)
-- vim.keymap.set("n", '<leader>d?', function() local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes) end)
-- vim.keymap.set("n", '<leader>de', function() require('telescope.builtin').diagnostics({default_text=":E:"}) end)
-- vim.keymap.set("n", "<leader>de", "<cmd>lua require('fzf-lua').diagnostics_workspace()<CR>")
