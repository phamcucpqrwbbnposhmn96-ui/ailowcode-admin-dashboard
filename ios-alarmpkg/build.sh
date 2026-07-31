#!/bin/bash
# iOS Alarm App - 快速构建脚本

set -e

echo "🚀 开始构建 iOS Alarm App..."

# 检查环境
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ 错误: 未找到 xcodebuild，请在 macOS 上运行此脚本"
    exit 1
fi

# 清理旧构建
rm -rf Build/ Archive.xcarchive

# 参数解析
SCHEME="${1:-AlarmApp}"
CONFIGURATION="${2:-Release}"
EXPORT_METHOD="${3:-development}"

echo "📱 构建参数:"
echo "   Scheme: $SCHEME"
echo "   Configuration: $CONFIGURATION"
echo "   Export Method: $EXPORT_METHOD"

# 构建Archive
echo ""
echo "🔨 正在构建 Archive..."
xcodebuild archive \
    -scheme "$SCHEME" \
    -configuration "$CONFIGURATION" \
    -destination 'generic/platform=iOS' \
    -archivePath "Archive.xcarchive" \
    CODE_SIGNING_ALLOWED=YES \
    CODE_SIGN_IDENTITY="iPhone Developer" \
    PROVISIONING_PROFILE_SPECIFIER="" \
    2>&1 | tail -20

# 导出IPA
echo ""
echo "📦 正在导出 IPA..."
xcodebuild -exportArchive \
    -archivePath "Archive.xcarchive" \
    -exportPath "Build" \
    -exportOptionsPlist export.plist \
    2>&1 | tail -20

# 检查结果
if [ -f "Build/*.ipa" ]; then
    IPA_PATH=$(find Build -name "*.ipa" -type f | head -1)
    echo ""
    echo "✅ 构建成功!"
    echo "📁 IPA 文件位置: $IPA_PATH"
    echo "📊 文件大小: $(du -h "$IPA_PATH" | cut -f1)"
    
    # 提供安装选项
    echo ""
    echo "💡 安装选项:"
    echo "   1. TestFlight: 上传到 App Store Connect"
    echo "   2. AirDrop: airplay \"$IPA_PATH\""
    echo "   3. 邮件发送: mail -s \"Alarm App\" your@email.com < \"$IPA_PATH\""
else
    echo "❌ 构建失败，请检查上方错误信息"
    exit 1
fi