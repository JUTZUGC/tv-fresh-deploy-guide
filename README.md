# tv-fresh 一键安装指南

> 第三方部署指南 · 非 tv-fresh 官方仓库。官方项目：[wangrongding/tv-fresh](https://github.com/wangrongding/tv-fresh)
> 内容来自官方文档（2026-11-03）。项目迭代快，请以[官方文档](https://github.com/wangrongding/tv-fresh#readme)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 不用自己敲命令，让百度搭子帮你把环境跑起来。

⚠️ 面向小米 / Redmi 电视（MIUI TV），需要开启 ADB 调试。用 `pm uninstall --user 0` 只对当前用户卸载，系统分区不动，可用 `cmd package install-existing` 还原。部分固件每次重启会复位 ADB 开关。不要动 `com.android.packageinstaller`、`com.mitv.tvplayer` 等核心组件，误删可能开不了机。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/tv-fresh-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会把技能装进 agent 的 skills 目录，再引导你开电视 ADB 并连接，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## tv-fresh 是什么？

tv-fresh 是开源的用 agent 通过 adb 卸掉小米电视的广告与预装，一条命令还能装回来（协议：MIT，<img src="https://img.shields.io/github/stars/wangrongding/tv-fresh?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

小米电视清理技能：通过 ADB 卸载当前用户的广告与预装应用、替换桌面、安装代理与影视仓，全程免 root 且记录可还原清单。

- 免 root，只对当前用户卸载
- 一条命令可还原
- 附分任务说明与一键脚本
- 含固件逆向实录
- agent 可读的技能结构
- MIT，脚本可审

（来源：[官方仓库](https://github.com/wangrongding/tv-fresh)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 545 stars | 名称搜索 21 条（每页 20 条时一页） |
| 免 root | 风险相对可控 |
| 卸载可按包名还原 | — |
| 附带分任务说明与脚本 | — |
| 有固件逆向实录 | — |
| MIT | 脚本可审 |

| 需要注意 | 说明 |
|---|---|
| 只面向小米 / Redmi 电视 | — |
| 需要 ADB 与同一局域网 | — |
| 部分固件 ADB 会复位 | — |
| 误删核心包可能开不了机 | — |
| 不同固件差异大 | — |

> 以上基于官方文档与社区反馈整理（2026-11-03），以官方最新文档为准。

## 快速部署（官方方式）

```bash
git clone https://github.com/wangrongding/tv-fresh ~/.agents/skills/tv-fresh
adb connect <TV_IP>:5555
echo "连接成功后按 SKILL.md 的清单逐项处理，保留还原记录"
```

部署步骤来源：[https://github.com/wangrongding/tv-fresh#readme](https://github.com/wangrongding/tv-fresh#readme)

## 验证状态

| 场景 | 状态 |
|---|---|
| README 确认小米电视、ADB 方式与可还原说明 | 已核对 2026-11-03 |
| 未实测连接电视与清理 | 说明 2026-11-03 |
| MCP 冒烟：initialize / tools/list 返回 get_guide、search_guide、get_project_info | 已验证 2026-11-03 |
| 非目标宿主调用 get_guide 被拦截（HOST_NOT_ALLOWED） | 已验证 2026-11-03 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

以 Agent Skill 形式安装，本身不含 MCP；本仓库的 MCP 只提供安装步骤、风险提示与常见问题。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-11-03）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\tv-fresh-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 准备

1. 电视开启开发者模式与 ADB 调试
2. 电脑与电视同一局域网
3. 安装 adb 并确认 `adb devices` 显示 device

## 连接

```bash
adb connect <TV_IP>:5555
adb devices
```

状态是 `unauthorized` 时，去电视上点允许。

## 还原

```bash
adb shell cmd package install-existing <包名>
```

处理前把要卸载的包名记下来，还原时逐条执行。

## 注意

- 只对当前用户卸载，恢复出厂会全部回来
- 部分固件重启后 ADB 开关复位
- 别碰系统安装器与播放器等核心包
- 换桌面后遥控器按键可能变化
- 不同固件包名不同，按实测清单来

## 常见坑

- 连不上：确认同 Wi-Fi、ADB 已开、IP 正确
- unauthorized：去电视上点允许
- 重启后失效：部分固件会复位 ADB，重新开启
- 开不了机：不要卸载系统安装器与播放器
- 桌面异常：先还原桌面相关包，再换方案
- 遥控器失灵：换桌面后按键映射会变
- 还原失败：用 `install-existing` 逐条恢复

## 免责声明

本仓库为第三方指南，与 tv-fresh 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-11-03），项目迭代快，请以[官方文档](https://github.com/wangrongding/tv-fresh#readme)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
