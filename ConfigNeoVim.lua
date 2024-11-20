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
vim.o.linespace = 8             -- Aumenta o espaço entre linhas
vim.o.guifont = "FiraCode Nerd Font:h14" -- Define fonte e tamanho

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
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        integrations = {
          treesitter = true,
          telescope = true,
          which_key = true,
          cmp = true,
          nvimtree = true,
        },
      })
      vim.cmd("colorscheme catppuccin-mocha")
    end,
  },

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
        ensure_installed = { "go", "javascript", "html", "css", "python", "rust", "lua" },
        highlight = { enable = true },
      })
    end,
  },

  -- Barra lateral com nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 30, side = "left" },
        renderer = { highlight_git = true, highlight_opened_files = "all" },
        filters = { dotfiles = false },
      })
      vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
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
          expand = function(args) require("luasnip").lsp_expand(args.body) end,
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
            "███╗   ██╗███████╗██╗   ██╗██╗███╗   ███╗",
            "████╗  ██║██╔════╝██║   ██║██║████╗ ████║",
            "██╔██╗ ██║█████╗  ██║   ██║██║██╔████╔██║",
            "██║╚██╗██║██╔══╝  ╚██╗ ██╔╝██║██║╚██╔╝██║",
            "██║ ╚████║███████╗ ╚████╔╝ ██║██║ ╚═╝ ██║",
            "╚═╝  ╚═══╝╚══════╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
          },
          center = {
            { icon = "🔍 ", desc = "Find File", action = "Telescope find_files", key = "f" },
            { icon = "🕒 ", desc = "Recent Files", action = "Telescope oldfiles", key = "r" },
            { icon = "⚙️ ", desc = "Config", action = "edit ~/.config/nvim/init.lua", key = "c" },
          },
          footer = { "Que grande Nerd!" },
        },
      })
    end,
  },

  -- Discord Rich Presence
  {
    "andweeb/presence.nvim",
    config = function()
      require("presence").setup({
        auto_update = true,
        neovim_image_text = "Skibidi",
        main_image = "file",
        buttons = true,
        editing_text = "Editando %s",
        file_explorer_text = "Explorando arquivos",
        git_commit_text = "Commitando mudanças",
        plugin_manager_text = "Gerenciando plugins",
      })
    end,
  },
})

-- Mensagem de boas-vindas
vim.cmd([[echo "O maior nerd de sempre KKKKKKKKKKKKKKKKKKKKK"]])
