# 📱 iOS Alarm App

这是一个使用 SwiftUI 构建的 iOS 闹钟应用，支持设置闹钟、本地通知提醒等功能。

## 🚀 快速开始

### 方法 1: 使用 GitHub Actions 构建（无需 Mac）
本项目已配置 GitHub Actions，你只需在仓库设置中添加以下 Secrets：
- `APPLE_DEVELOPER_CERTIFICATE` - 你的 `.p12` 证书文件（base64编码）
- `APPLE_DEVELOPER_CERTIFICATE_PASSWORD` - 证书密码
- `APPLE_PROVISIONING_PROFILE` - Provisioning Profile（base64编码）
- `APPLE_TEAM_ID` - Apple Developer Team ID

然后访问仓库的 **Actions** 标签页，手动触发 workflow，等待构建完成即可下载 IPA。

### 方法 2: 本地使用 Xcode 构建（需要 Mac）
```bash
# 1. 克隆仓库
git clone https://github.com/phamcucpqrwbbnposhmn96-ui/ailowcode-admin-dashboard.git
cd ailowcode-admin-dashboard/ios-alarmpkg

# 2. 在 Xcode 中打开 Package.swift
# 3. 添加你的开发者账号和团队
# 4. 选择设备 → Run (Cmd+R) 或 Archive 导出 IPA
```

## 📋 功能特性

- ⏰ 设置闹钟时间
- 🔔 本地通知提醒（支持贪睡和关闭操作）
- 🔄 每日重复闹钟
- 🎨 SwiftUI 现代化界面

## ⚠️ 重要说明

关于静音模式：iOS 系统级静音会禁用所有应用通知声音，这是系统限制，无法绕过。建议用户在使用闹钟前确保音量正常或关闭静音开关。

## 📁 项目结构

```
ios-alarmpkg/
├── Package.swift          # Swift Package 配置
├── export.plist           # IPA 导出配置
├── README.md
└── AlarmApp/
    ├── main.swift         # 应用入口
    ├── AlarmView.swift    # 主界面视图
    ├── AddAlarmView.swift # 添加闹钟子视图
    ├── AlarmManager.swift # 通知调度管理
    └── Alarm.swift        # 闹钟数据结构
```

## 🔧 故障排查

如果 GitHub Actions 构建失败，请检查：
1. 证书是否正确上传且 base64 编码正确
2. Team ID 是否与 Xcode 中一致
3. Provisioning Profile 是否包含正确的 App ID
4. Workflow 日志中的具体错误信息
