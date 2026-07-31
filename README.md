# 📱 iOS Alarm App (Source Code)

这是一个使用 Swift Package Manager 构建的 SwiftUI iOS 闹钟应用。完整源文件可在 `AlarmApp/` 目录下找到。

## 🎯 功能特性

- ⏰ 设置单次或每日重复的闹钟
- 🔔 使用系统本地通知提醒（支持贪睡和关闭操作）
- 🎨 SwiftUI 现代化界面
- 📱 兼容 iOS 17+

## ⚠️ 重要说明

### 关于静音模式的问题
您的原始需求中提到"即使开启静音也要响铃"。请注意：

**iOS 系统设计中，当设备进入静音模式（侧边开关开启）时，所有应用的通知都会被静音，这是系统级的强制限制，任何第三方应用都无法绕过。** 这是 Apple 为了保护用户体验而设计的核心机制。

当前版本的标准做法是：
- 使用 `.default` 声音（最大音量）
- 启用通知振动
- 允许用户在设置中单独为应用取消静音限制

如需实现"静音模式响铃"功能，需要使用系统级 Alarm API（仅限系统级应用）或获取特殊 entitlements（仅苹果官方应用可用）。

## 🛠️ 编译 IPA 指南

### 前置条件
1. **Mac 电脑** - Xcode 只能在 macOS 上运行
2. **Xcode 15+** - 从 Mac App Store 下载
3. **Apple Developer 账号** ($99/年) - 用于签名和测试
4. **开发者证书** - 已在开发者中心配置好的 Provisioning Profile

### 快速启动方法（推荐）

**方案 A：使用 Xcode 直接打开**

```bash
# 1. 克隆仓库
git clone https://github.com/phamcucpqrwbbnposhmn96-ui/ailowcode-admin-dashboard.git
cd ailowcode-admin-dashboard

# 2. 打开 Xcode
open ios-alarmpkg/Package.swift

# 3. Xcode 会提示创建一个 Workspace，点击 Create

# 4. 在 Xcode 中：
#    - 选择目标设备（iPhone/iPad）
#    - 在 Signing & Capabilities 中添加你的团队/证书
#    - 点击 Run (Cmd+R) 编译并安装到真机

# 5. 生成 IPA：
#    Product → Archive → 完成后再从 Organizer 导出 IPA
```

**方案 B：使用命令行（更高级）**

```bash
# 1. 进入项目目录
cd /path/to/ailowcode-admin-dashboard/ios-alarmpkg

# 2. 构建并发布到应用商店（需证书）
xcodebuild -workspace ios-alarmpkg.xcworkspace \
           scheme "AlarmApp" \
           archive -archivePath "./AlarmApp.archive" \
           SDK=iphoneos \
           CODE_SIGN_IDENTITY="iPhone Developer: Your Name" \
           PROVISIONING_PROFILE="Your Provisioning Profile UUID"

# 3. 从 archive 生成 IPA
xcodebuild -exportArchive -archivePath "./AlarmApp.archive" \
           -exportPath "./Build" \
           -exportOptionsPlist export.plist
```

需要的 `export.plist` 示例：
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key><string>development</string>
    <key>compileWithoutDebugSymbols</key><true/>
    <key>stripSwiftSymbols</key><true/>
    <key>signingCertificate</key><string>iOS Development</string>
</dict>
</plist>
```

## 📁 项目结构

```
ios-alarmpkg/
├── Package.swift       # Swift Package 配置
└── AlarmApp/
    ├── main.swift      # 应用入口
    ├── Alarm.swift     # 闹钟数据结构
    ├── AddAlarmView.swift   # 添加闹钟子视图
    ├── AlarmView.swift     # 主界面视图
    └── AlarmManager.swift # 通知调度管理
```

## 🧩 扩展建议

如需增强功能，可考虑添加：
- 🎵 自定义铃声选择器（从本地音频文件或系统音库）
- 🌙 贪睡功能（Snooze - 5/10/15分钟）
- 🗺️ 基于位置的地理围栏闹钟
- 📊 使用 Core Data 持久化存储闹钟列表
- ☀️ 日出/日落自动闹钟
- 🔄 iCloud 同步多设备闹钟列表
