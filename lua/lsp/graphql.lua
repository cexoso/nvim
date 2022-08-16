require'lspconfig'.graphql.setup{ }

local util = require'lspconfig'.util
return {
  config = {},
  root_dir = util.root_pattern("package.json"),
}


