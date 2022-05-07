local util = require'lspconfig'.util
return {
    cmd = {"rust-analyzer"},
    filetypes = {"rust"},
    log_level = 2,
    root_dir = util.root_pattern("Cargo.toml", "rust-project.json"),
    settings = {
      ["rust-analyzer"] = {}
    }
}
