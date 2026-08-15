require("config.options")
require("config.keybinds")
--require("config.lazy")
--



vim.pack.add({
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  {src="https://github.com/nvim-lua/plenary.nvim"}, 
  {src="https://github.com/nvim-telescope/telescope.nvim"},
  {src="https://github.com/nvim-tree/nvim-tree.lua"},
  {src="https://github.com/nvim-tree/nvim-web-devicons"},
})

	    local builtin = require('telescope.builtin')
	    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
	    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
	    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
	    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.lsp.enable('luals')
vim.lsp.enable('cppls')
vim.lsp.enable('vtsls')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true, desc = 'Go to definition' })

vim.cmd("set completeopt+=noselect")

-- Register the plugin and attach custom data metadata
vim.pack.add({
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main',
    data = {
      on_update = function()
        vim.cmd('TSUpdate')
      end,
    },
  },
})

-- Create an autocommand to run the hook after vim.pack finishes updating
vim.api.nvim_create_autocmd('PackChanged', {
  desc = 'Execute Tree-sitter update hook',
  callback = function(event)
    local data = event.data or {}
    local spec_data = vim.tbl_get(data, 'spec', 'data') or {}
    if type(spec_data.on_update) == 'function' then
      vim.schedule(spec_data.on_update)
    end
  end,
})


  -- disable netrw at the very start of your init.lua
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  -- optionally enable 24-bit colour
  vim.opt.termguicolors = true

  -- empty setup using defaults
  require("nvim-tree").setup()

  -- OR setup with a config

  ---@type nvim_tree.config
  local config = {
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
update_focused_file = {
    enable = true,
    update_cwd = true,
}
  }
  require("nvim-tree").setup(config)


  vim.g.nvim_tree_respect_buf_cwd = 1
