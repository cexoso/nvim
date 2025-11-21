local M = {}

-- 清理 markdown 代码块标记
local function remove_markdown_code_blocks(text)
  -- 去除开头的 ```language 标记
  text = text:gsub("^%s*```%w*%s*\n?", "")
  -- 去除结尾的 ``` 标记
  text = text:gsub("\n?%s*```%s*$", "")
  -- 去除前后空白
  text = text:gsub("^%s*(.-)%s*$", "%1")
  return text
end

-- 获取选中的文本
local function get_visual_selection()
  -- 保存当前寄存器内容
  local save_reg = vim.fn.getreg('"')
  local save_regtype = vim.fn.getregtype('"')

  -- 复制选中的文本到寄存器
  vim.cmd('normal! gv"xy')
  local selection = vim.fn.getreg('x')

  -- 恢复寄存器
  vim.fn.setreg('"', save_reg, save_regtype)

  return selection
end

-- 使用 Claude AI 处理选中的代码
function M.ask_claude_and_replace()
  -- 获取选中的文本
  local selection = get_visual_selection()

  if not selection or selection == "" then
    vim.notify("No text selected", vim.log.levels.WARN)
    return
  end

  -- 提示用户输入问题
  vim.ui.input({
    prompt = "Ask Claude: ",
  }, function(user_question)
    if not user_question or user_question == "" then
      vim.notify("No question provided", vim.log.levels.WARN)
      return
    end

    -- 构建完整的提示词
    local full_prompt = string.format(
      "Here is the code:\n\n```\n%s\n```\n\n%s\n\nIMPORTANT: Return ONLY the raw code without any markdown code blocks (no ```), without any explanations, and without any extra formatting. Just the plain code that can directly replace the original.",
      selection,
      user_question
    )

    -- 创建临时文件保存提示词
    local tmp_file = vim.fn.tempname()
    local file = io.open(tmp_file, "w")
    if not file then
      vim.notify("Failed to create temporary file", vim.log.levels.ERROR)
      return
    end
    file:write(full_prompt)
    file:close()

    -- 构建 claude 命令，从临时文件读取提示词
    -- 直接使用 claude 路径
    local claude_path = '/Users/xiongjie/.local/state/fnm_multishells/10066_1757247168380/bin/claude'

    -- 检查文件是否存在
    if vim.fn.filereadable(claude_path) == 0 then
      vim.notify("Claude command not found at: " .. claude_path, vim.log.levels.ERROR)
      vim.fn.delete(tmp_file)
      return
    end

    local cmd = string.format('cat %s | %s -p "$(cat)"', vim.fn.shellescape(tmp_file), vim.fn.shellescape(claude_path))

    -- 显示正在处理的消息
    vim.notify("Asking Claude AI...", vim.log.levels.INFO)

    -- 异步执行命令
    vim.fn.jobstart({'bash', '-c', cmd}, {
      stdout_buffered = true,
      on_stdout = function(_, data)
        if data then
          -- 过滤空行
          local result = table.concat(data, "\n"):gsub("^%s*(.-)%s*$", "%1")

          -- 清理 markdown 代码块标记
          result = remove_markdown_code_blocks(result)

          if result ~= "" then
            -- 在主线程中执行替换操作
            vim.schedule(function()
              -- 获取当前选中区域的起始和结束位置
              local start_pos = vim.fn.getpos("'<")
              local end_pos = vim.fn.getpos("'>")
              local start_line = start_pos[2]
              local end_line = end_pos[2]  -- 修复：应该是 [2] 不是 [3]

              -- 将结果按行分割
              local result_lines = {}
              for line in result:gmatch("[^\r\n]+") do
                table.insert(result_lines, line)
              end

              -- 替换选中的行（一步完成）
              vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, result_lines)

              vim.notify("Code replaced successfully!", vim.log.levels.INFO)
            end)
          end
        end
      end,
      on_stderr = function(_, data)
        if data and #data > 0 then
          local err_msg = table.concat(data, "\n")
          if err_msg ~= "" then
            vim.schedule(function()
              vim.notify("Claude AI Error: " .. err_msg, vim.log.levels.ERROR)
            end)
          end
        end
      end,
      on_exit = function(_, exit_code)
        -- 清理临时文件
        vim.fn.delete(tmp_file)

        if exit_code ~= 0 then
          vim.schedule(function()
            vim.notify("Claude AI command failed with exit code: " .. exit_code, vim.log.levels.ERROR)
          end)
        end
      end
    })
  end)
end

return M
