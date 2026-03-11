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
        -- 默认配置
        dir_path = "assets/images",  -- 图片保存目录（相对于当前文件）
        file_name = "%Y-%m-%d-%H-%M-%S",  -- 图片文件名格式
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
          -- markdown 文件专用配置
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

      -- 检查剪贴板是否包含图片（macOS）
      local function has_image_in_clipboard()
        local handle = io.popen("pngpaste - 2>&1 > /dev/null; echo $?")
        if not handle then return false end

        local result = handle:read("*a")
        handle:close()

        return result:match("^0") ~= nil
      end

      -- 在 markdown 文件中使用 p 键智能粘贴
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          -- Normal 模式下的 p 键：智能粘贴图片或文本
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
