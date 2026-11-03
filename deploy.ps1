# tv-fresh 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/wangrongding/tv-fresh#readme
# 更新日期：2026-11-03
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

git clone https://github.com/wangrongding/tv-fresh "$HOME\.agents\skills\tv-fresh"
adb connect <TV_IP>:5555
Write-Host "连接成功后按 SKILL.md 的清单逐项处理，保留还原记录"

Write-Host ''

Write-Host '部署完成'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/wangrongding/tv-fresh#readme'
