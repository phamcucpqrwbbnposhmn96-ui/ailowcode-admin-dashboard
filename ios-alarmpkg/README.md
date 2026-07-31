# 📱 iOS Alarm App (警报器应用)

这是一个使用 Swift Package Manager 构建的现代化 iOS 闹钟应用。

## 🚀 快速开始

### 方法一：使用 Codemagic 在线构建（推荐）

1. 访问 https://codemagic.io
2. 用 GitHub 账号登录并导入本仓库
3. 在 Settings → Authentication 添加 Apple Developer 证书
4. 点击 "Trigger build" 开始构建
5. 完成后下载 `.ipa` 文件

**优点**：无需 Mac，完全云端构建

### 方法二：本地 Xcode 构建

```bash
# 克隆仓库
git clone https://github.com/phamcucpqrwbbnposhmn96-ui/ailowcode-admin-dashboard.git
cd ailowcode-admin-dashboard/ios-alarmpkg

# 用 Xcode 打开（自动创建 Workspace）
open Package.swift

# 在 Xcode 中:
# 1. 选择目标设备（iPhone）
# 2. 在 Signing & Capabilities 添加你的开发团队
# 3. 点击 Run (Cmd+R) 运行到真机
# 4. Product → Archive 打包

# 或使用命令行（需配置好证书）
chmod +x build.sh
./build.sh AlarmApp Release development
```

### 方法三：使用 App Center (微软)

1. 访问 https://appcenter.ms
2. 注册并创建新 iOS 应用
3. 关联 GitHub 仓库
4. 等待自动构建
5. 下载生成的 IPA

## 📋 功能特性

- ⏰ 设置单次或每日重复闹钟
- 🔔 本地通知提醒（支持贪睡和关闭操作）
- 🎨 SwiftUI 现代化界面
- 📱 兼容 iOS 17+
- 🔕 静音模式提醒（显示通知，但声音受系统限制）

## ⚠️ 关于静音模式的说明

iOS 系统设计中，当设备开启静音（侧边开关）时，所有应用通知都会被静音。这是 Apple 的系统级保护机制，第三方应用无法绕过。如需听到闹钟声，请在使用前关闭静音开关或在系统设置中为该 App 单独授权声音。

## 🛠️ 项目结构

```
ios-alarmpkg/
├── AlarmApp/              # Swift 源代码目录
│   ├── main.swift        # 应用入口点
│   ├── AlarmView.swift   # 主界面视图
│   ├── AddAlarmView.swift # 添加闹钟弹窗
│   ├── AlarmManager.swift # 通知调度管理
│   └── Alarm.swift       # 数据结构定义
├── Package.swift         # Swift Package 配置文件
├── build.sh             # 本地构建脚本（需 Mac）
├── export.plist         # IPA 导出配置模板
└── README.md           # 本说明文档
```

## 🔐 构建所需的证书信息

要成功构建 IPA，你需要准备：

1. **Apple Developer 账号** ($99/年)
   - 注册地址：https://developer.apple.com/account
   - 个人账号也可使用，功能受限但足够个人测试

2. **Certificate（证书）**
   - 类型：iOS Distribution 或 iOS Development
   - 导出为 `.p12` 文件（包含私钥）
   - 获取方式：Xcode → Preferences → Accounts → Manage Certificates

3. **Provisioning Profile（描述文件）**
   - 关联你的 App Bundle ID
   - 包含可安装的设备列表
   - 获取方式：Xcode 自动创建或使用 Apple Developer Portal

4. **Team ID**
   - 从 Apple Developer Portal 获取
   - 或从 Xcode → Preferences → Accounts 查看

## 🧪 常见问题

**Q: 如何使用我的证书？**
A: 
- 在线构建(Codemagic/App Center)：在平台设置中上传 `.p12` 文件和密码
- 本地构建：在 Xcode 中选择你的开发团队自动签名

**Q: 构建失败怎么办？**
A: 
1. 检查证书和 Profile 是否过期
2. 确认 Bundle ID 与 App ID 匹配
3. 确保 Team ID 正确

**Q: IPA 无法安装到 iPhone？**
A: 
- development 模式只能安装到注册过的设备（最多100台）
- 如要分享给其他人，需使用 ad-hoc 或 enterprise 分发方式
- 推荐使用 TestFlight 进行公测分发

## 📝 License

MIT License - 自由使用、修改和分发