# OpenClaw 技能学习包

从 Claude Code 学习的7个高级技能，已完全适配 OpenClaw 架构。

## 包内容

这个学习包包含7个完整的 OpenClaw 技能，都是从 Claude Code 的优秀设计中学习并转化而来：

### 核心技能 (7个)

1. **记忆审查技能** (`memory-review`) - 审查和组织所有记忆层
2. **定时任务技能** (`kairos-lite`) - 自然语言定时任务创建
3. **验证门技能** (`verification-gate`) - 任务完成后质量验证
4. **上下文压缩技能** (`context-compressor`) - 智能上下文压缩
5. **群组协调技能** (`swarm-coordinator`) - 多代理任务协调
6. **风格提取技能** (`style-extractor`) - 用户偏好学习
7. **梦想记忆技能** (`dream-memory`) - 自动记忆整理

## 快速开始

### 方法一：完整安装（推荐）
```bash
# 1. 复制整个包到 OpenClaw 工作空间
cp -r skill-learning-package/* /path/to/openclaw/workspace/

# 2. 运行安装脚本
cd /path/to/openclaw/workspace/skill-learning-package
./install-all.sh
```

### 方法二：逐个技能安装
```bash
# 查看可用技能
ls skill-learning-package/skills/

# 安装单个技能
./install-skill.sh memory-review
./install-skill.sh kairos-lite
```

### 方法三：手动学习
```bash
# 阅读学习指南
cat skill-learning-package/LEARNING-GUIDE.md

# 查看技能文档
ls skill-learning-package/docs/
```

## 技能概述

### 1. 记忆审查技能 (`memory-review`)
**功能**: 审查和组织 OpenClaw 的所有记忆层
**来源**: Claude Code 的 `remember` 技能
**核心价值**: 保持记忆系统整洁有序

### 2. 定时任务技能 (`kairos-lite`)
**功能**: 自然语言定时任务创建和管理
**来源**: Claude Code 的 `/loop` 技能
**核心价值**: 简化定期任务调度

### 3. 验证门技能 (`verification-gate`)
**功能**: 任务完成后质量验证系统
**来源**: Claude Code 的 `verify` 技能
**核心价值**: 确保任务执行质量

### 4. 上下文压缩技能 (`context-compressor`)
**功能**: 9段式智能上下文压缩
**来源**: Claude Code 的压缩系统
**核心价值**: 优化上下文使用效率

### 5. 群组协调技能 (`swarm-coordinator`)
**功能**: 多代理任务分解和协调
**来源**: Claude Code 的协调器系统
**核心价值**: 处理复杂多组件任务

### 6. 风格提取技能 (`style-extractor`)
**功能**: 学习用户偏好和协作风格
**来源**: Claude Code 的记忆提取系统
**核心价值**: 个性化交互优化

### 7. 梦想记忆技能 (`dream-memory`)
**功能**: 自动记忆整理和压缩
**来源**: Claude Code 的自动整理系统
**核心价值**: 后台记忆维护

## 技能间协同

这些技能设计为协同工作：
```
用户请求 → [群组协调] 分解任务 → [多个代理并行] → [风格提取] 学习
         ↓
[验证门] 验证结果 → [上下文压缩] 优化 → [梦想记忆] 自动整理
         ↓
[记忆审查] 用户检查 → [定时任务] 定期维护
```

## 学习路径建议

### 初学者路径
1. 先学习 `记忆审查` + `定时任务` (最实用)
2. 再学习 `验证门` + `上下文压缩` (提高质量)
3. 最后学习其他高级技能

### 按功能分组学习
- **记忆管理组**: 记忆审查 + 梦想记忆 + 风格提取
- **任务管理组**: 定时任务 + 验证门 + 群组协调
- **优化组**: 上下文压缩 + 风格提取

### 完整学习计划
1. 第1周: 记忆审查 + 定时任务
2. 第2周: 验证门 + 上下文压缩
3. 第3周: 风格提取 + 梦想记忆
4. 第4周: 群组协调 + 技能集成

## 技术要求

### 必需条件
- OpenClaw 最新版本
- 基本的文件系统访问权限
- 标准工具支持 (read, write, edit, exec, cron等)

### 推荐配置
- 至少 100MB 可用磁盘空间
- 支持心跳和cron功能
- 多会话/子代理支持
- 内存管理功能启用

## 安装验证

安装后运行验证脚本：
```bash
./verify-installation.sh
```

检查项目：
- 所有技能目录存在
- SKILL.md 文件完整
- 必要的配置文件就绪
- 集成测试通过

## 故障排除

### 常见问题
1. **权限问题**: 确保有适当的文件访问权限
2. **配置冲突**: 检查现有配置是否冲突
3. **资源不足**: 确保有足够的磁盘和内存
4. **版本不兼容**: 确认 OpenClaw 版本支持

### 获取帮助
- 查看详细文档: `docs/TROUBLESHOOTING.md`
- 运行诊断: `./diagnose.sh`
- 查看日志: `tail -f logs/installation.log`

## 更新和维护

### 技能更新
```bash
# 检查更新
./check-updates.sh

# 应用更新
./update-skills.sh
```

### 配置备份
```bash
# 备份当前配置
./backup-config.sh

# 恢复配置
./restore-config.sh backup-2026-04-02.tar.gz
```

## 贡献和反馈

### 报告问题
```bash
# 生成问题报告
./report-issue.sh "问题描述"

# 查看已知问题
cat docs/KNOWN-ISSUES.md
```

### 提供反馈
1. 使用反馈表: `docs/FEEDBACK-FORM.md`
2. 提交改进建议
3. 分享使用经验

## 许可证和版权

### 技能来源
- 所有技能设计灵感来自 Claude Code
- 已完全适配 OpenClaw 架构
- 不包含 Claude Code 的原始代码

### 使用条款
- 仅供学习和内部使用
- 可自由修改和适配
- 建议保留原始设计理念说明

## 联系信息

### 包维护者
- 原始学习: 当前 OpenClaw 实例
- 包创建: 2026-04-02
- 版本: 1.0.0

### 支持渠道
- OpenClaw 社区
- 技能开发文档
- 问题跟踪系统

---

**重要提示**: 这个学习包是 Claude Code 优秀设计的 OpenClaw 适配版本。所有技能都经过重新设计和架构适配，不包含任何 Claude Code 的原始代码。

开始学习之旅吧！每个技能都有详细文档和示例，帮助你快速掌握这些强大的能力。