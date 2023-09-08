local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
  }
  vim.lsp.buf.execute_command(params)
end

lspconfig.dartls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"dart", "language-server", "--protocol=lsp"},
  filetypes = { 'dart' },
  root_dir = util.root_pattern 'pubspec.yaml',
  init_options = {
    onlyAnalyzeProjectsWithOpenFiles = true,
    suggestFromUnimportedLibraries = true,
    closingLabels = true,
    outline = true,
    flutterOutline = true
  },
  settings = {
    dart = {
      completeFunctionCalls = true,
      showTodos = true,
    },
  },
  docs = {
    description = [[
      https://github.com/dart-lang/sdk/tree/master/pkg/analysis_server/tool/lsp_spec laguage server for dart
    ]],
    defaut_config = {
      root_dir = [[root_pattern("pubspec.yaml")]],
    },
  },
}


lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    }
  },
  commands = {
     OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    }
  }
}

lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"python"},
})

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"gopls"},
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparms = true,
      }
    },
  },
}
