#!/bin/bash
# 创建 OpenClaw 技能学习包分发文件

set -e

echo "========================================"
echo "OpenClaw 技能学习包打包程序"
echo "========================================"
echo ""

# 包信息
PACKAGE_NAME="openclaw-skill-learning-package"
VERSION="1.0.0"
DATE=$(date +%Y%m%d)

# 创建临时目录
TEMP_DIR=$(mktemp -d)
PACKAGE_DIR="$TEMP_DIR/$PACKAGE_NAME-$VERSION"

echo "📦 创建包: $PACKAGE_NAME-$VERSION"
echo "📁 临时目录: $TEMP_DIR"
echo ""

# 创建包目录结构
mkdir -p "$PACKAGE_DIR"
mkdir -p "$PACKAGE_DIR/skills"
mkdir -p "$PACKAGE_DIR/docs"

echo "📋 复制文件..."
echo ""

# 复制核心文件
echo "  复制核心文件..."
cp README.md "$PACKAGE_DIR/"
cp LEARNING-GUIDE.md "$PACKAGE_DIR/"
cp QUICK-START.md "$PACKAGE_DIR/"
cp install-all.sh "$PACKAGE_DIR/"
cp install-skill.sh "$PACKAGE_DIR/"
cp verify-installation.sh "$PACKAGE_DIR/"
cp create-package.sh "$PACKAGE_DIR/"

# 复制文档
echo "  复制文档..."
cp docs/* "$PACKAGE_DIR/docs/" 2>/dev/null || true

# 复制技能
echo "  复制技能..."
for skill in skills/*; do
    if [ -d "$skill" ]; then
        skill_name=$(basename "$skill")
        echo "    - $skill_name"
        cp -r "$skill" "$PACKAGE_DIR/skills/"
    fi
done

# 创建版本文件
echo "  创建版本信息..."
cat > "$PACKAGE_DIR/VERSION.md" << EOF
# OpenClaw 技能学习包 - 版本信息

## 包信息
- 名称: $PACKAGE_NAME
- 版本: $VERSION
- 创建日期: $(date)
- 包含技能: 7个

## 技能列表
1. memory-review - 记忆审查技能
2. kairos-lite - 定时任务技能
3. verification-gate - 验证门技能
4. context-compressor - 上下文压缩技能
5. swarm-coordinator - 群组协调技能
6. style-extractor - 风格提取技能
7. dream-memory - 梦想记忆技能

## 来源说明
所有技能设计灵感来自 Claude Code，但已完全重新设计和适配 OpenClaw 架构。
不包含任何 Claude Code 的原始代码。

## 许可证
仅供学习和内部使用。
可自由修改和适配。
建议保留原始设计理念说明。

## 联系方式
- 包创建者: 当前 OpenClaw 实例
- 创建时间: 2026-04-02
- 更新: 通过版本控制系统管理
EOF

# 创建安装说明
echo "  创建安装说明..."
cat > "$PACKAGE_DIR/INSTALL.md" << EOF
# 安装说明

## 快速安装
\`\`\`bash
# 解压包
tar -xzf $PACKAGE_NAME-$VERSION.tar.gz

# 进入目录
cd $PACKAGE_NAME-$VERSION

# 安装所有技能
./install-all.sh

# 或指定工作空间
./install-all.sh /path/to/your/openclaw/workspace
\`\`\`

## 单个技能安装
\`\`\`bash
# 安装单个技能
./install-skill.sh memory-review

# 查看可用技能
ls skills/
\`\`\`

## 验证安装
\`\`\`bash
# 验证安装结果
./verify-installation.sh
\`\`\`

## 开始学习
\`\`\`bash
# 查看快速开始指南
cat QUICK-START.md

# 查看详细学习指南
cat LEARNING-GUIDE.md
\`\`\`

## 获取帮助
- 查看 README.md 获取概述
- 查看 docs/ 目录获取详细文档
- 运行验证脚本检查问题
- 参考技能目录中的 SKILL.md 文件
EOF

# 创建文件清单
echo "  创建文件清单..."
find "$PACKAGE_DIR" -type f | sort > "$PACKAGE_DIR/FILES.txt"

# 统计信息
TOTAL_FILES=$(find "$PACKAGE_DIR" -type f | wc -l)
TOTAL_DIRS=$(find "$PACKAGE_DIR" -type d | wc -l)
TOTAL_SIZE=$(du -sh "$PACKAGE_DIR" | cut -f1)

echo ""
echo "📊 包统计:"
echo "  总文件数: $TOTAL_FILES"
echo "  总目录数: $TOTAL_DIRS"
echo "  总大小: $TOTAL_SIZE"
echo ""

# 创建压缩包
echo "📦 创建压缩包..."
cd "$TEMP_DIR"
tar -czf "$PACKAGE_NAME-$VERSION.tar.gz" "$PACKAGE_NAME-$VERSION"

# 计算哈希值
MD5_SUM=$(md5sum "$PACKAGE_NAME-$VERSION.tar.gz" | cut -d' ' -f1)
SHA256_SUM=$(sha256sum "$PACKAGE_NAME-$VERSION.tar.gz" | cut -d' ' -f1)

# 移动包到当前目录
cd - > /dev/null
mv "$TEMP_DIR/$PACKAGE_NAME-$VERSION.tar.gz" .

# 清理临时目录
rm -rf "$TEMP_DIR"

# 输出结果
echo "✅ 打包完成!"
echo ""
echo "📦 包文件: $PACKAGE_NAME-$VERSION.tar.gz"
echo "📏 文件大小: $(du -h "$PACKAGE_NAME-$VERSION.tar.gz" | cut -f1)"
echo ""
echo "🔒 完整性校验:"
echo "  MD5:    $MD5_SUM"
echo "  SHA256: $SHA256_SUM"
echo ""
echo "📁 包内容结构:"
tar -tzf "$PACKAGE_NAME-$VERSION.tar.gz" | head -20
echo "  ... (共 $TOTAL_FILES 个文件)"
echo ""
echo "🚀 分发说明:"
echo "  1. 发送包文件: $PACKAGE_NAME-$VERSION.tar.gz"
echo "  2. 提供校验和用于验证完整性"
echo "  3. 包含安装说明 (INSTALL.md)"
echo ""
echo "💡 使用建议:"
echo "  1. 接收方验证校验和"
echo "  2. 解压后运行验证脚本"
echo "  3. 按学习指南逐步学习"
echo ""
echo "📄 创建分发说明文件..."
cat > "DISTRIBUTION-$DATE.md" << EOF
# 分发说明 - $PACKAGE_NAME $VERSION

## 包信息
- 文件名: $PACKAGE_NAME-$VERSION.tar.gz
- 大小: $(du -h "$PACKAGE_NAME-$VERSION.tar.gz" | cut -f1)
- 创建时间: $(date)
- MD5: $MD5_SUM
- SHA256: $SHA256_SUM

## 包含内容
7个从 Claude Code 学习并转化的 OpenClaw 技能:
1. 记忆审查技能 (memory-review)
2. 定时任务技能 (kairos-lite)
3. 验证门技能 (verification-gate)
4. 上下文压缩技能 (context-compressor)
5. 群组协调技能 (swarm-coordinator)
6. 风格提取技能 (style-extractor)
7. 梦想记忆技能 (dream-memory)

## 安装步骤
\`\`\`bash
# 1. 验证下载完整性
md5sum $PACKAGE_NAME-$VERSION.tar.gz
# 应该输出: $MD5_SUM

# 2. 解压
tar -xzf $PACKAGE_NAME-$VERSION.tar.gz

# 3. 安装
cd $PACKAGE_NAME-$VERSION
./install-all.sh

# 4. 验证
./verify-installation.sh
\`\`\`

## 学习资源
- QUICK-START.md - 快速开始指南
- LEARNING-GUIDE.md - 详细学习指南
- docs/ - 详细文档目录
- 每个技能的 SKILL.md 文件

## 支持
- 查看 README.md 获取概述
- 运行验证脚本诊断问题
- 参考技能文档获取详细帮助

## 注意事项
1. 所有技能设计灵感来自 Claude Code，但已完全重新设计
2. 不包含任何 Claude Code 的原始代码
3. 仅供学习和内部使用
4. 可自由修改和适配

---
分发时间: $(date)
分发者: 当前 OpenClaw 实例
EOF

echo "📄 分发说明已保存: DISTRIBUTION-$DATE.md"
echo ""
echo "========================================"
echo "打包程序完成!"
echo "========================================"

exit 0