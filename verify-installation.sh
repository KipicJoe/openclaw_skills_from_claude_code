#!/bin/bash
# OpenClaw 技能安装验证脚本

set -e

echo "========================================"
echo "OpenClaw 技能安装验证"
echo "========================================"
echo ""

# 默认工作空间
WORKSPACE="${1:-/root/.openclaw/workspace}"

if [ ! -d "$WORKSPACE" ]; then
    echo "❌ 错误: 工作空间不存在: $WORKSPACE"
    exit 1
fi

echo "📁 验证工作空间: $WORKSPACE"
echo ""

# 技能列表
SKILLS=(
    "memory-review"
    "kairos-lite"
    "verification-gate"
    "context-compressor"
    "swarm-coordinator"
    "style-extractor"
    "dream-memory"
)

TOTAL_SKILLS=${#SKILLS[@]}
INSTALLED_COUNT=0
VERIFIED_COUNT=0

echo "🔍 开始验证 $TOTAL_SKILLS 个技能..."
echo ""

# 验证函数
verify_skill() {
    local skill_name="$1"
    local skill_dir="$WORKSPACE/skills/$skill_name"
    local status="❌"
    
    echo "验证: $skill_name"
    echo "  位置: $skill_dir"
    
    # 检查目录是否存在
    if [ ! -d "$skill_dir" ]; then
        echo "  状态: 目录不存在"
        echo ""
        return 1
    fi
    
    # 检查必需文件
    local missing_files=()
    local required_files=("SKILL.md")
    
    for file in "${required_files[@]}"; do
        if [ ! -f "$skill_dir/$file" ]; then
            missing_files+=("$file")
        fi
    done
    
    # 检查文件内容
    local content_issues=0
    if [ -f "$skill_dir/SKILL.md" ]; then
        # 检查文件大小
        local size=$(wc -c < "$skill_dir/SKILL.md" 2>/dev/null || echo "0")
        if [ "$size" -lt 100 ]; then
            content_issues=$((content_issues + 1))
            echo "  警告: SKILL.md 文件过小 ($size 字节)"
        fi
        
        # 检查关键内容
        if ! grep -q "description:" "$skill_dir/SKILL.md" 2>/dev/null; then
            content_issues=$((content_issues + 1))
            echo "  警告: SKILL.md 缺少 description"
        fi
        
        if ! grep -q "version:" "$skill_dir/SKILL.md" 2>/dev/null; then
            content_issues=$((content_issues + 1))
            echo "  警告: SKILL.md 缺少 version"
        fi
    fi
    
    # 输出结果
    if [ ${#missing_files[@]} -eq 0 ] && [ $content_issues -eq 0 ]; then
        status="✅"
        INSTALLED_COUNT=$((INSTALLED_COUNT + 1))
        VERIFIED_COUNT=$((VERIFIED_COUNT + 1))
        echo "  状态: 安装完整且验证通过"
    elif [ ${#missing_files[@]} -eq 0 ]; then
        status="⚠️ "
        INSTALLED_COUNT=$((INSTALLED_COUNT + 1))
        echo "  状态: 安装完整但内容有警告"
    else
        status="❌"
        echo "  状态: 安装不完整，缺少文件: ${missing_files[*]}"
    fi
    
    # 显示文件统计
    local file_count=$(find "$skill_dir" -type f 2>/dev/null | wc -l)
    echo "  文件数: $file_count"
    
    # 显示主要文件
    echo "  主要文件:"
    for file in "$skill_dir"/*.md; do
        if [ -f "$file" ]; then
            local filename=$(basename "$file")
            local lines=$(wc -l < "$file" 2>/dev/null || echo "0")
            echo "    - $filename ($lines 行)"
        fi
    done
    
    echo ""
    return 0
}

# 验证所有技能
for skill in "${SKILLS[@]}"; do
    verify_skill "$skill"
done

# 检查配置文件
echo "⚙️ 检查配置文件..."
CONFIG_FILE="$WORKSPACE/config/skills-config.json"
if [ -f "$CONFIG_FILE" ]; then
    echo "  ✅ 配置文件存在: $CONFIG_FILE"
    
    # 检查配置内容
    if grep -q "installed_skills" "$CONFIG_FILE" 2>/dev/null; then
        echo "  ✅ 配置文件格式正确"
    else
        echo "  ⚠️  配置文件格式可能不正确"
    fi
else
    echo "  ⚠️  配置文件不存在"
fi

echo ""

# 检查学习材料
echo "📚 检查学习材料..."
LEARN_DIR="$WORKSPACE/learn"
if [ -d "$LEARN_DIR" ]; then
    local learn_files=$(find "$LEARN_DIR" -type f -name "*.md" 2>/dev/null | wc -l)
    echo "  ✅ 学习目录存在，包含 $learn_files 个学习文件"
else
    echo "  ⚠️  学习目录不存在"
fi

echo ""

# 检查日志目录
echo "📝 检查日志目录..."
LOG_DIR="$WORKSPACE/logs"
if [ -d "$LOG_DIR" ]; then
    local log_files=$(find "$LOG_DIR" -type f -name "*.log" 2>/dev/null | wc -l)
    echo "  ✅ 日志目录存在，包含 $log_files 个日志文件"
else
    echo "  ⚠️  日志目录不存在"
fi

echo ""

# 总结报告
echo "========================================"
echo "验证完成总结"
echo "========================================"
echo ""
echo "📊 总体统计:"
echo "  总技能数: $TOTAL_SKILLS"
echo "  已安装: $INSTALLED_COUNT"
echo "  验证通过: $VERIFIED_COUNT"
echo "  安装率: $((INSTALLED_COUNT * 100 / TOTAL_SKILLS))%"
echo "  验证率: $((VERIFIED_COUNT * 100 / TOTAL_SKILLS))%"
echo ""

# 技能状态表
echo "📋 技能状态详情:"
for skill in "${SKILLS[@]}"; do
    local skill_dir="$WORKSPACE/skills/$skill"
    local status="❌"
    
    if [ -d "$skill_dir" ]; then
        if [ -f "$skill_dir/SKILL.md" ]; then
            # 简单检查文件内容
            if grep -q "description:" "$skill_dir/SKILL.md" 2>/dev/null; then
                status="✅"
            else
                status="⚠️ "
            fi
        else
            status="⚠️ "
        fi
    fi
    
    echo "  $status $skill"
done

echo ""

# 建议和下一步
echo "🚀 建议和下一步:"

if [ $INSTALLED_COUNT -eq $TOTAL_SKILLS ] && [ $VERIFIED_COUNT -eq $TOTAL_SKILLS ]; then
    echo "  ✅ 所有技能安装完整且验证通过!"
    echo "  下一步: 开始学习第一个技能"
    echo "    cat $WORKSPACE/learn/QUICK-START.md"
elif [ $INSTALLED_COUNT -eq $TOTAL_SKILLS ]; then
    echo "  ⚠️  所有技能已安装，但部分验证有警告"
    echo "  下一步: 检查有警告的技能，然后开始学习"
    echo "    查看详细验证信息如上"
else
    echo "  ❌ 部分技能未安装或安装不完整"
    echo "  下一步: 重新运行安装脚本"
    echo "    cd /path/to/skill-learning-package"
    echo "    ./install-all.sh $WORKSPACE"
fi

echo ""
echo "🔧 详细诊断:"
echo "  查看技能目录: ls -la $WORKSPACE/skills/"
echo "  查看安装日志: ls -la $WORKSPACE/logs/"
echo "  查看学习材料: ls -la $WORKSPACE/learn/"

echo ""
echo "========================================"
echo "验证完成于: $(date)"
echo "========================================"

# 创建验证报告
REPORT_DIR="$WORKSPACE/reports"
mkdir -p "$REPORT_DIR"
REPORT_FILE="$REPORT_DIR/verification-$(date +%Y%m%d-%H%M%S).txt"

{
echo "OpenClaw 技能安装验证报告"
echo "生成时间: $(date)"
echo "工作空间: $WORKSPACE"
echo ""
echo "总体统计:"
echo "- 总技能数: $TOTAL_SKILLS"
echo "- 已安装: $INSTALLED_COUNT"
echo "- 验证通过: $VERIFIED_COUNT"
echo "- 安装率: $((INSTALLED_COUNT * 100 / TOTAL_SKILLS))%"
echo "- 验证率: $((VERIFIED_COUNT * 100 / TOTAL_SKILLS))%"
echo ""
echo "详细状态:"
for skill in "${SKILLS[@]}"; do
    local skill_dir="$WORKSPACE/skills/$skill"
    if [ -d "$skill_dir" ]; then
        echo "- $skill: 已安装"
        if [ -f "$skill_dir/SKILL.md" ]; then
            local lines=$(wc -l < "$skill_dir/SKILL.md" 2>/dev/null || echo "0")
            echo "  SKILL.md: $lines 行"
        fi
    else
        echo "- $skill: 未安装"
    fi
done
} > "$REPORT_FILE"

echo ""
echo "📄 详细报告已保存: $REPORT_FILE"

exit 0