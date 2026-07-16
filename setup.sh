#!/usr/bin/env bash
set -e

echo "==> 检查系统依赖"
for cmd in rg fd make node npm fnm; do
  if command -v "$cmd" &>/dev/null; then
    echo "  ok: $cmd"
  else
    echo "  WARNING: $cmd 未找到，部分功能可能缺失"
  fi
done

echo ""
echo "==> 安装 npm 全局包"
npm install -g @vue/typescript-plugin
echo "  ok: @vue/typescript-plugin"

echo ""
echo "==> 完成"
echo "    1. 打开 nvim，执行 :Lazy sync 同步插件"
echo "    2. Mason 会自动安装 ts_ls / rust_analyzer / gopls"
