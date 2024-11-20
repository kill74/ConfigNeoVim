Neovim Configuration

Este repositório contém uma configuração personalizada do Neovim, focada em produtividade, personalização e suporte para diversas linguagens de programação. Com uma interface moderna, plugins bem selecionados e mapeamentos otimizados, esta configuração é ideal para desenvolvedores que buscam eficiência e um ambiente de codificação visualmente agradável.
Principais Recursos

    Lazy.nvim: Gerenciador de plugins rápido e minimalista.
    Tema Catppuccin: Estilo visual elegante com suporte a diversas integrações.
    Telescope: Ferramenta poderosa de busca e navegação.
    Nvim-Tree: Gerenciador de arquivos integrado.
    Treesitter: Realce de sintaxe avançado.
    LSP e Autocomplete: Suporte a várias linguagens com autocompletar inteligente.
    Dashboard personalizado: Tela inicial customizada com atalhos rápidos.

Instalação
Pré-requisitos

    Neovim 0.9+
    Git
    Um gerenciador de plugins (configurado no script com Lazy.nvim)

Passos

Clone este repositório no seu diretório de configuração do Neovim:

    git clone https://github.com/seu-usuario/seu-repo ~/.config/nvim

Abra o Neovim para que o Lazy.nvim instale os plugins automaticamente:

    nvim

Aproveite sua nova configuração!

Mapeamentos
Teclas principais

    <Leader>: Definido como Espaço.
    Salvar e sair:
        <Leader>w para salvar.
        <Leader>q para sair.
    Navegar entre splits:
        <C-h>, <C-l>, <C-j>, <C-k> para mover entre splits.
    Telescope:
        <Leader>ff para buscar arquivos.
        <Leader>fg para busca no conteúdo dos arquivos.
    Nvim-Tree:
        <Leader>e para abrir/fechar o gerenciador de arquivos.

Plugins Utilizados
Temas e Interface

    Catppuccin: Tema personalizável com suporte a plugins.
    Dashboard: Tela inicial estilizada.

Navegação e Busca

    Telescope: Fuzzy finder rápido e versátil.
    Nvim-Tree: Navegador de arquivos.

Syntax e LSP

    Treesitter: Realce de sintaxe baseado em análise da árvore do código.
    nvim-lspconfig: Suporte para servidores LSP.
    nvim-cmp: Framework de autocompletar extensível.

Configuração do LSP

O LSP (Language Server Protocol) está configurado para oferecer suporte às seguintes linguagens:

    Python: Usando Pyright.
    JavaScript/TypeScript: Usando tsserver.
    Go: Usando gopls.
    HTML/CSS: Usando html e cssls.
    Lua: Configurado para Neovim.
