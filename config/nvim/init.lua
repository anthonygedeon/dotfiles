require("plugins")

vim.cmd [[ set nobackup ]]
vim.cmd [[ set noswapfile ]]

--line numbering
vim.wo.number = true
vim.wo.relativenumber = true

--tab spacing
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true

vim.opt.syntax = 'enable'

--remap esc to jk
vim.api.nvim_set_keymap('i', 'jk', '<esc>', {noremap=true})

-- disable esc
vim.api.nvim_set_keymap('i', '<esc>', '<Nop>', {noremap=true}) 

--disable up arrow key
vim.api.nvim_set_keymap('n', '<Up>', '<Nop>', {noremap=true}) 

--disable down arrow key
vim.api.nvim_set_keymap('n', '<Down>', '<Nop>', {noremap=true}) 

--disable left arrow key
vim.api.nvim_set_keymap('n', '<Left>', '<Nop>', {noremap=true}) 

--disable right arrow key
vim.api.nvim_set_keymap('n', '<Right>', '<Nop>', {noremap=true}) 

--universal formatter config

--colors
require('github-theme').setup({
	theme_style = "dark_default"
})

--lualine config
require('lualine').setup({
	options = {
		theme = 'dark_default',
		section_separators = '', component_separators = ''
	}
})

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "cpp", "lua", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

--telescope config
--https://github.com/nvim-telescope/telescope.nvim
vim.api.nvim_set_keymap('n', 'ff', ':Telescope find_files<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', 'fg', ':Telescope live_grep<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', 'fb', ':Telescope buffers<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', 'fh', ':Telescope help_tags<cr>', {noremap=true})

--https://github.com/lewis6991/gitsigns.nvim
require('gitsigns').setup()

--https://github.com/kyazdani42/nvim-tree.lua
vim.g.nvim_tree_show_icons = {
	git = 0, 
	folder = 0, 
	files = 0 
}
require('nvim-tree').setup({
		view = {
			width = 35
		}
})

vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap=true})

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
require('lspconfig').clangd.setup{}
require('lspconfig').pyright.setup{}

-- luasnip setup
local luasnip = require 'luasnip'
require("luasnip/loaders/from_vscode").load(
    {paths={'~/.config/nvim/my_lsp_snips'}}
)

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
}

