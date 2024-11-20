-- BOOTSTRAP lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- CONFIGURAÇÕES BÁSICAS
vim.o.number = true             -- Mostrar número das linhas
vim.o.relativenumber = true     -- Números relativos
vim.o.tabstop = 4               -- Tamanho do tab
vim.o.shiftwidth = 4            -- Indentação
vim.o.expandtab = true          -- Usa espaços no lugar de tab
vim.o.termguicolors = true      -- Habilitar cores no terminal
vim.o.wrap = false              -- Não quebrar linha
vim.o.clipboard = "unnamedplus" -- Compartilhar clipboard com o sistema
vim.o.splitright = true         -- Abrir splits à direita
vim.o.splitbelow = true         -- Abrir splits abaixo
vim.o.ignorecase = true         -- Busca ignorando maiúsculas/minúsculas
vim.o.smartcase = true          -- Mas respeitar se houver maiúsculas
vim.o.updatetime = 300          -- Melhorar desempenho
vim.o.timeoutlen = 500          -- Tempo para esperar por atalhos

-- TECLA LÍDER
vim.g.mapleader = " "

-- MAPEAMENTOS
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Salvar e sair
map("n", "<leader>w", ":w<CR>", opts)   -- <Leader>w para salvar
map("n", "<leader>q", ":q<CR>", opts)  -- <Leader>q para sair

-- Navegar entre splits
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)

-- Abrir Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)

-- CONFIGURAÇÃO DE PLUGINS
require("lazy").setup({
  -- Tema Catppuccin
-- Tema Catppuccin
{
  "catppuccin/nvim",
  name = "catppuccin",
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- Escolha entre latte, frappe, macchiato e mocha
      integrations = {
        treesitter = true,
        telescope = true,
        which_key = true,
        cmp = true, -- Integração com nvim-cmp
        nvimtree = true, -- Integração com nvim-tree
      },
    })
    vim.cmd("colorscheme catppuccin-mocha") -- Define o tema para Mocha
  end,
}

  -- Navegação com Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup()
    end,
  },

  -- Syntax Highlight com Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all", -- Ou especifique linguagens: { "lua", "python" }
        highlight = { enable = true },
      })
    end,
  },

  -- Barra lateral com nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Ícones para arquivos
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30, -- Largura da barra lateral
          side = "left", -- Lado da barra (pode ser "left" ou "right")
        },
        renderer = {
          highlight_git = true, -- Destacar arquivos Git
          highlight_opened_files = "all",
        },
        filters = {
          dotfiles = false, -- Mostrar arquivos ocultos
        },
      })
      -- Mapeamento para abrir/fechar a barra
      vim.api.nvim_set_keymap(
        "n",
        "<leader>e",
        ":NvimTreeToggle<CR>",
        { noremap = true, silent = true }
      )
    end,
  },

  -- LSP e Autocomplete
  { "neovim/nvim-lspconfig" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  -- Dashboard
  {
    "glepnir/dashboard-nvim",
    config = function()
      local db = require("dashboard")
      db.setup({
        theme = "doom",
        config = {
          header = {
            "",
            "",
            "███████╗███╗   ██╗███████╗██╗   ██╗██╗███╗   ███╗",
            "██╔════╝████╗  ██║██╔════╝██║   ██║██║████╗ ████║",
            "███████╗██╔██╗ ██║█████╗  ██║   ██║██║██╔████╔██║",
            "╚════██║██║╚██╗██║██╔══╝  ╚██╗ ██╔╝██║██║╚██╔╝██║",
            "███████║██║ ╚████║███████╗ ╚████╔╝ ██║██║ ╚═╝ ██║",
            "╚══════╝╚═╝  ╚═══╝╚══════╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
          },
          center = {
            { icon = "🧌 ", desc = "Find File", action = "Telescope find_files", key = "f" },
            { icon = "🐲 ", desc = "Recent Files", action = "Telescope oldfiles", key = "r" },
            { icon = "🐋 ", desc = "Restore Session", action = "SessionLoad", key = "s" },
            { icon = "🛠️ ", desc = "Config", action = "edit ~/.config/nvim/init.lua", key = "c" },
          },
          footer = {"O MAIOR NERD DE SEMPRE"},
        },
      })
    end,
  },
})

-- CONFIGURAÇÃO DE LSP
local lspconfig = require("lspconfig")

-- Habilitar LSP para linguagens específicas
lspconfig.pyright.setup({})   -- Python
lspconfig.ts_ls.setup({})     -- JavaScript/TypeScript
lspconfig.gopls.setup({})     -- Go
lspconfig.html.setup({})      -- HTML
lspconfig.cssls.setup({})     -- CSS
lspconfig.lua_ls.setup({      -- Lua
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})

-- Mensagem de boas-vindas
vim.cmd([[echo "QUE GRANDE NERD HAHAHAHAHAH!"]])
