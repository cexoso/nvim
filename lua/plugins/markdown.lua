-- Markdown preview plugin
return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- Image paste plugin
  {
    "HakonHarnes/img-clip.nvim",
    ft = "markdown",
    opts = {
      default = {
        dir_path = "assets/images",
        file_name = "%Y-%m-%d-%H-%M-%S",
        extension = "jpg",
        process_cmd = "magick png:- jpg:-",
        url_encode_path = false,
        use_absolute_path = false,
        relative_to_current_file = true,
        prompt_for_file_name = false,
        show_dir_path_in_prompt = false,
        use_cursor_in_template = true,
        insert_mode_after_paste = false,
      },
      filetypes = {
        markdown = {
          url_encode_path = false,
          template = "![$CURSOR]($FILE_PATH)",
          drag_and_drop = {
            insert_mode = true,
          },
        },
      },
    },
    config = function(_, opts)
      require("img-clip").setup(opts)

      local function has_image_in_clipboard()
        local handle = io.popen("pngpaste - 2>&1 > /dev/null; echo $?")
        if not handle then return false end
        local result = handle:read("*a")
        handle:close()
        return result:match("^0") ~= nil
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.keymap.set("n", "p", function()
            if has_image_in_clipboard() then
              vim.cmd("PasteImage")
            else
              vim.api.nvim_feedkeys("p", "n", false)
            end
          end, { buffer = true, desc = "Paste image or text" })
        end,
      })
    end,
  },
}
