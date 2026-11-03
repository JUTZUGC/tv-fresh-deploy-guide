#!/usr/bin/env bash
set -euo pipefail
# tv-fresh 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/wangrongding/tv-fresh#readme
# 更新日期：2026-11-03
# 类型：script
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }

mkdir -p .download
cd .download

git clone https://github.com/wangrongding/tv-fresh ~/.agents/skills/tv-fresh
adb connect <TV_IP>:5555
echo "连接成功后按 SKILL.md 的清单逐项处理，保留还原记录"

echo ""

echo "部署完成"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/wangrongding/tv-fresh#readme"
