#!/bin/bash
# OpenClaw 技能学习包 - 完整安装脚本

set -e

echo "========================================"
echo "OpenClaw 技能学习包安装程序"
echo "========================================"
echo ""

# 检查工作空间
WORKSPACE="${1:-/root/.openclaw/workspace}"
if [ ! -d "$WORKSPACE" ]; then
    echo "❌ 错误: OpenClaw 工作空间不存在: $WORKSPACE"
    echo "请指定正确的 OpenClaw 工作空间路径"
    exit 1
fi

echo "📁 工作空间: $WORKSPACE"
echo ""

# 创建日志目录
LOG_DIR="$WORKSPACE/logs"
mkdir -p "$LOG_DIR"
INSTALL_LOG="$LOG_DIR/skill-install-$(date +%Y%m%d-%H%M%S).log"

echo "📝 安装日志: $INSTALL_LOG"
echo ""

# 记录安装开始
{
echo "========================================"
echo "OpenClaw 技能安装开始: $(date)"
echo "工作空间: $WORKSPACE"
echo "========================================"
echo ""
} | tee -a "$INSTALL_LOG"

# 函数：安装单个技能
install_skill() {
    local skill_name="$1"
    local skill_dir="$WORKSPACE/skills/$skill_name"
    
    echo "🔧 安装技能: $skill_name" | tee -a "$INSTALL_LOG"
    
    # 检查技能源文件
    local source_dir="skills/$skill_name"
    if [ ! -d "$source_dir" ]; then
        echo "  ❌ 技能源目录不存在: $source_dir" | tee -a "$INSTALL_LOG"
        return 1
    fi
    
    # 创建目标目录
    mkdir -p "$skill_dir"
    
    # 复制技能文件
    echo "  📋 复制文件..." | tee -a "$INSTALL_LOG"
    cp -r "$source_dir"/* "$skill_dir/" 2>/dev/null || true
    
    # 检查主要文件
    if [ -f "$skill_dir/SKILL.md" ]; then
        echo "  ✅ SKILL.md 已安装" | tee -a "$INSTALL_LOG"
    else
        echo "  ⚠️  警告: SKILL.md 未找到" | tee -a "$INSTALL_LOG"
    fi
    
    # 设置权限
    chmod -R 755 "$skill_dir" 2>/dev/null || true
    
    echo "  ✅ 技能安装完成: $skill_name" | tee -a "$INSTALL_LOG"
    echo "" | tee -a "$INSTALL_LOG"
    
    return 0
}

# 函数：验证技能安装
verify_skill() {
    local skill_name="$1"
    local skill_dir="$WORKSPACE/skills/$skill_name"
    
    echo "  🔍 验证技能: $skill_name" | tee -a "$INSTALL_LOG"
    
    local missing_files=0
    
    # 检查必需文件
    for file in "SKILL.md"; do
        if [ ! -f "$skill_dir/$file" ]; then
            echo "    ❌ 缺少文件: $file" | tee -a "$INSTALL_LOG"
            missing_files=$((missing_files + 1))
        fi
    done
    
    if [ $missing_files -eq 0 ]; then
        echo "    ✅ 技能验证通过" | tee -a "$INSTALL_LOG"
        return 0
    else
        echo "    ⚠️  技能验证失败: 缺少 $missing_files 个文件" | tee -a "$INSTALL_LOG"
        return 1
    fi
}

# 安装所有技能
SKILLS=(
    "memory-review"
    "kairos-lite" 
    "verification-gate"
    "context-compressor"
    "swarm-coordinator"
    "style-extractor"
    "dream-memory"
)

echo "📦 开始安装 7 个技能..." | tee -a "$INSTALL_LOG"
echo "" | tee -a "$INSTALL_LOG"

INSTALLED_COUNT=0
FAILED_COUNT=0

for skill in "${SKILLS[@]}"; do
    if install_skill "$skill"; then
        INSTALLED_COUNT=$((INSTALLED_COUNT + 1))
    else
        FAILED_COUNT=$((FAILED_COUNT + 1))
    fi
done

echo "" | tee -a "$INSTALL_LOG"
echo "📊 安装统计:" | tee -a "$INSTALL_LOG"
echo "  ✅ 成功安装: $INSTALLED_COUNT 个技能" | tee -a "$INSTALL_LOG"
echo "  ❌ 安装失败: $FAILED_COUNT 个技能" | tee -a "$INSTALL_LOG"
echo "" | tee -a "$INSTALL_LOG"

# 验证所有技能
echo "🔍 开始验证所有技能..." | tee -a "$INSTALL_LOG"
echo "" | tee -a "$INSTALL_LOG"

VERIFIED_COUNT=0
FAILED_VERIFY_COUNT=0

for skill in "${SKILLS[@]}"; do
    if verify_skill "$skill"; then
        VERIFIED_COUNT=$((VERIFIED_COUNT + 1))
    else
        FAILED_VERIFY_COUNT=$((FAILED_VERIFY_COUNT + 1))
    fi
done

echo "" | tee -a "$INSTALL_LOG"
echo "📊 验证统计:" | tee -a "$INSTALL_LOG"
echo "  ✅ 验证通过: $VERIFIED_COUNT 个技能" | tee -a "$INSTALL_LOG"
echo "  ❌ 验证失败: $FAILED_VERIFY_COUNT 个技能" | tee -a "$INSTALL_LOG"
echo "" | tee -a "$INSTALL_LOG"

# 创建配置文件
echo "⚙️ 创建配置文件..." | tee -a "$INSTALL_LOG"
CONFIG_DIR="$WORKSPACE/config"
mkdir -p "$CONFIG_DIR"

# 创建技能配置文件
cat > "$CONFIG_DIR/skills-config.json" << EOF
{
  "installed_skills": [
    "memory-review",
    "kairos-lite",
    "verification-gate",
    "context-compressor",
    "swarm-coordinator",
    "style-extractor",
    "dream-memory"
  ],
  "installation_date": "$(date -Iseconds)",
  "version": "1.0.0",
  "source": "Claude Code Learning Package",
  "stats": {
    "total_skills": 7,
    "installed": $INSTALLED_COUNT,
    "verified": $VERIFIED_COUNT
  }
}
EOF

echo "  ✅ 配置文件创建完成: $CONFIG_DIR/skills-config.json" | tee -a "$INSTALL_LOG"
echo "" | tee -a "$INSTALL_LOG"

# 创建学习指南链接
echo "📚 创建学习材料..." | tee -a "$INSTALL_LOG"
LEARN_DIR="$WORKSPACE/learn"
mkdir -p "$LEARN_DIR"

# 复制学习文档
cp -r docs/* "$LEARN_DIR/" 2>/dev/null || true
cp LEARNING-GUIDE.md "$LEARN_DIR/" 2>/dev/null || true
cp QUICK-START.md "$LEARN_DIR/" 2>/dev/null || true

echo "  ✅ 学习材料已复制到: $LEARN_DIR" | tee -a "$INSTALL_LOG"
echo "" | tee -a "$INSTALL_LOG"

# 安装完成总结
{
echo "========================================"
echo "安装完成总结: $(date)"
echo "========================================"
echo ""
echo "🎉 安装完成!"
echo ""
echo "📁 安装位置: $WORKSPACE/skills/"
echo "📚 学习材料: $WORKSPACE/learn/"
echo "📋 配置文件: $WORKSPACE/config/skills-config.json"
echo "📝 安装日志: $INSTALL_LOG"
echo ""
echo "🔧 安装的技能 ($INSTALLED_COUNT/7):"
for skill in "${SKILLS[@]}"; do
    if [ -d "$WORKSPACE/skills/$skill" ]; then
        echo "  ✅ $skill"
    else
        echo "  ❌ $skill (失败)"
    fi
done
echo ""
echo "🚀 下一步:"
echo "1. 阅读学习指南: $LEARN_DIR/LEARNING-GUIDE.md"
echo "2. 查看快速开始: $LEARN_DIR/QUICK-START.md"
echo "3. 运行验证脚本: ./verify-skills.sh"
echo "4. 开始学习第一个技能!"
echo ""
echo "💡 提示: 每个技能都有详细的 SKILL.md 文档"
echo "      在技能目录中查看具体使用方法"
echo ""
echo "========================================"
} | tee -a "$INSTALL_LOG"

# 创建完成标志
touch "$WORKSPACE/.skills-installed"

echo ""
echo "✅ 安装程序完成!"
echo ""
echo "要开始学习，请运行:"
echo "  cat $LEARN_DIR/QUICK-START.md"
echo ""
echo "或查看详细指南:"
echo "  cat $LEARN_DIR/LEARNING-GUIDE.md"

exit 0