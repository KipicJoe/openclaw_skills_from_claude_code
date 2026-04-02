#!/bin/bash
# OpenClaw 技能学习包 - 单个技能安装脚本

set -e

echo "========================================"
echo "OpenClaw 单个技能安装程序"
echo "========================================"
echo ""

# 检查参数
if [ $# -lt 1 ]; then
    echo "用法: $0 <技能名称> [工作空间路径]"
    echo ""
    echo "可用技能:"
    echo "  memory-review      记忆审查技能"
    echo "  kairos-lite        定时任务技能"
    echo "  verification-gate  验证门技能"
    echo "  context-compressor 上下文压缩技能"
    echo "  swarm-coordinator  群组协调技能"
    echo "  style-extractor    风格提取技能"
    echo "  dream-memory       梦想记忆技能"
    echo ""
    echo "示例:"
    echo "  $0 memory-review"
    echo "  $0 kairos-lite /path/to/workspace"
    exit 1
fi

SKILL_NAME="$1"
WORKSPACE="${2:-/root/.openclaw/workspace}"

# 检查工作空间
if [ ! -d "$WORKSPACE" ]; then
    echo "❌ 错误: OpenClaw 工作空间不存在: $WORKSPACE"
    exit 1
fi

echo "🔧 安装技能: $SKILL_NAME"
echo "📁 工作空间: $WORKSPACE"
echo ""

# 检查技能是否存在
SKILL_SOURCE="skills/$SKILL_NAME"
if [ ! -d "$SKILL_SOURCE" ]; then
    echo "❌ 错误: 技能 '$SKILL_NAME' 不存在"
    echo ""
    echo "可用技能目录:"
    ls -la skills/ 2>/dev/null | grep '^d' | awk '{print "  " $9}'
    exit 1
fi

# 创建日志
LOG_DIR="$WORKSPACE/logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/install-$SKILL_NAME-$(date +%Y%m%d-%H%M%S).log"

echo "📝 安装日志: $LOG_FILE"
echo ""

# 开始安装
{
echo "========================================"
echo "技能安装开始: $(date)"
echo "技能: $SKILL_NAME"
echo "工作空间: $WORKSPACE"
echo "========================================"
echo ""
} | tee -a "$LOG_FILE"

# 技能信息
echo "📋 技能信息:" | tee -a "$LOG_FILE"
if [ -f "$SKILL_SOURCE/SKILL.md" ]; then
    # 提取技能描述
    DESCRIPTION=$(grep -i "description:" "$SKILL_SOURCE/SKILL.md" | head -1 | sed 's/.*description://' | tr -d '\"' | xargs)
    if [ -n "$DESCRIPTION" ]; then
        echo "  描述: $DESCRIPTION" | tee -a "$LOG_FILE"
    fi
    
    # 提取版本
    VERSION=$(grep -i "version:" "$SKILL_SOURCE/SKILL.md" | head -1 | sed 's/.*version://' | tr -d '\"' | xargs)
    if [ -n "$VERSION" ]; then
        echo "  版本: $VERSION" | tee -a "$LOG_FILE"
    fi
fi
echo "" | tee -a "$LOG_FILE"

# 检查目标目录
SKILL_TARGET="$WORKSPACE/skills/$SKILL_NAME"
if [ -d "$SKILL_TARGET" ]; then
    echo "⚠️  警告: 技能目录已存在: $SKILL_TARGET" | tee -a "$LOG_FILE"
    echo "  备份现有文件..." | tee -a "$LOG_FILE"
    
    # 创建备份
    BACKUP_DIR="$WORKSPACE/backups/$SKILL_NAME-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    cp -r "$SKILL_TARGET"/* "$BACKUP_DIR/" 2>/dev/null || true
    echo "  备份创建于: $BACKUP_DIR" | tee -a "$LOG_FILE"
    
    # 清空目标目录
    rm -rf "$SKILL_TARGET"/*
else
    # 创建目标目录
    mkdir -p "$SKILL_TARGET"
fi

# 复制文件
echo "📋 复制文件..." | tee -a "$LOG_FILE"
cp -r "$SKILL_SOURCE"/* "$SKILL_TARGET/" 2>&1 | tee -a "$LOG_FILE"

# 统计文件
FILE_COUNT=$(find "$SKILL_TARGET" -type f | wc -l)
echo "  已复制 $FILE_COUNT 个文件" | tee -a "$LOG_FILE"

# 设置权限
echo "🔒 设置权限..." | tee -a "$LOG_FILE"
chmod -R 755 "$SKILL_TARGET" 2>/dev/null || true

# 验证安装
echo "🔍 验证安装..." | tee -a "$LOG_FILE"

MISSING_FILES=()
REQUIRED_FILES=("SKILL.md")

for file in "${REQUIRED_FILES[@]}"; do
    if [ ! -f "$SKILL_TARGET/$file" ]; then
        MISSING_FILES+=("$file")
    fi
done

if [ ${#MISSING_FILES[@]} -eq 0 ]; then
    echo "  ✅ 必需文件完整" | tee -a "$LOG_FILE"
else
    echo "  ❌ 缺少必需文件: ${MISSING_FILES[*]}" | tee -a "$LOG_FILE"
fi

# 检查文件大小
echo "📊 文件统计:" | tee -a "$LOG_FILE"
for file in "$SKILL_TARGET"/*.md; do
    if [ -f "$file" ]; then
        SIZE=$(wc -c < "$file")
        LINES=$(wc -l < "$file")
        FILENAME=$(basename "$file")
        echo "  $FILENAME: $LINES 行, $SIZE 字节" | tee -a "$LOG_FILE"
    fi
done

# 更新配置文件
echo "⚙️ 更新配置..." | tee -a "$LOG_FILE"
CONFIG_DIR="$WORKSPACE/config"
mkdir -p "$CONFIG_DIR"

CONFIG_FILE="$CONFIG_DIR/skills-config.json"
if [ ! -f "$CONFIG_FILE" ]; then
    cat > "$CONFIG_FILE" << EOF
{
  "installed_skills": [],
  "installation_date": "$(date -Iseconds)",
  "version": "1.0.0"
}
EOF
fi

# 更新已安装技能列表
if grep -q "\"$SKILL_NAME\"" "$CONFIG_FILE" 2>/dev/null; then
    echo "  ℹ️  技能已在配置中" | tee -a "$LOG_FILE"
else
    # 简单的 JSON 更新（如果 jq 可用则使用 jq）
    if command -v jq >/dev/null 2>&1; then
        jq ".installed_skills += [\"$SKILL_NAME\"]" "$CONFIG_FILE" > "$CONFIG_FILE.tmp" && mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"
        echo "  ✅ 配置已更新" | tee -a "$LOG_FILE"
    else
        echo "  ⚠️  警告: jq 不可用，手动更新配置" | tee -a "$LOG_FILE"
    fi
fi

# 创建学习链接
echo "📚 创建学习链接..." | tee -a "$LOG_FILE"
LEARN_DIR="$WORKSPACE/learn"
mkdir -p "$LEARN_DIR"

# 复制技能特定的学习材料
if [ -f "docs/$SKILL_NAME-LEARN.md" ]; then
    cp "docs/$SKILL_NAME-LEARN.md" "$LEARN_DIR/"
    echo "  ✅ 学习指南已复制" | tee -a "$LOG_FILE"
fi

# 安装完成
{
echo ""
echo "========================================"
echo "安装完成: $(date)"
echo "========================================"
echo ""
echo "🎉 技能 '$SKILL_NAME' 安装完成!"
echo ""
echo "📁 安装位置: $SKILL_TARGET"
echo "📝 主要文件:"
ls -la "$SKILL_TARGET/"*.md 2>/dev/null | awk '{print "  " $9}'
echo ""
echo "📖 查看技能文档:"
echo "  cat $SKILL_TARGET/SKILL.md | head -20"
echo ""
echo "🚀 快速开始:"
echo "  1. 阅读技能文档: $SKILL_TARGET/SKILL.md"
echo "  2. 查看使用示例（如果存在）"
echo "  3. 尝试使用新技能"
echo ""
if [ ${#MISSING_FILES[@]} -gt 0 ]; then
    echo "⚠️  注意: 缺少必需文件 ${MISSING_FILES[*]}"
    echo "     技能可能无法正常工作"
    echo ""
fi
echo "========================================"
} | tee -a "$LOG_FILE"

echo ""
echo "✅ 技能 '$SKILL_NAME' 安装完成!"
echo ""
echo "下一步:"
echo "  cat $SKILL_TARGET/SKILL.md | less"
echo ""

exit 0