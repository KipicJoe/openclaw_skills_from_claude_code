# OpenClaw 技能学习包 - 快速开始指南

在30分钟内开始使用从 Claude Code 学习的7个高级技能。

## 立即开始

### 1. 安装所有技能（5分钟）
```bash
# 进入技能包目录
cd /path/to/skill-learning-package

# 运行安装脚本（默认安装到 /root/.openclaw/workspace）
./install-all.sh

# 或指定工作空间
./install-all.sh /path/to/your/openclaw/workspace
```

### 2. 验证安装（2分钟）
```bash
# 检查安装的技能
ls -la /root/.openclaw/workspace/skills/

# 应该看到7个技能目录
```

### 3. 学习第一个技能（10分钟）
从最简单的技能开始：

#### 选项A: 记忆审查技能
```bash
# 查看技能文档
cat /root/.openclaw/workspace/skills/memory-review/SKILL.md | head -50

# 运行一次测试审查
# （在实际 OpenClaw 会话中运行）
# /memory-review --dry-run
```

#### 选项B: 定时任务技能
```bash
# 查看技能文档
cat /root/.openclaw/workspace/skills/kairos-lite/SKILL.md | head -50

# 学习基本语法
# /loop 5m check status
# /loop 1h backup files
```

### 4. 尝试第一个任务（10分钟）
选择一个简单的实践任务：

#### 任务1: 检查你的记忆系统
```
在 OpenClaw 会话中运行:
/memory-review --recent-days 3 --dry-run
查看分析结果，了解你的记忆状态
```

#### 任务2: 创建一个定时提醒
```
在 OpenClaw 会话中运行:
/loop 10m "检查是否有新消息"
观察任务创建和确认
```

#### 任务3: 验证一个文件
```
在 OpenClaw 会话中运行:
/verify file:/etc/hosts --syntax
（或验证其他你熟悉的文件）
```

## 5分钟快速了解所有技能

### 技能1: 记忆审查 (`memory-review`)
- **一句话描述**: 审查和组织你的所有记忆文件
- **核心命令**: `/memory-review [选项]`
- **立即尝试**: `/memory-review --dry-run`

### 技能2: 定时任务 (`kairos-lite`)
- **一句话描述**: 用自然语言创建定时任务
- **核心命令**: `/loop [间隔] <任务>`
- **立即尝试**: `/loop 5m "检查系统状态"`

### 技能3: 验证门 (`verification-gate`)
- **一句话描述**: 任务完成后确保一切正常
- **核心命令**: `/verify <检查内容>`
- **立即尝试**: `/verify "系统正常运行"`

### 技能4: 上下文压缩 (`context-compressor`)
- **一句话描述**: 智能压缩长对话保留关键信息
- **核心命令**: `/compress [目标]`
- **立即尝试**: `/compress conversation`

### 技能5: 风格提取 (`style-extractor`)
- **一句话描述**: 学习你的偏好并个性化服务
- **核心命令**: `/style-extractor [操作]`
- **立即尝试**: `/style-extractor analyze`

### 技能6: 梦想记忆 (`dream-memory`)
- **一句话描述**: 自动整理和优化记忆系统
- **核心命令**: `/dream-memory [操作]`
- **立即尝试**: `/dream-memory status`

### 技能7: 群组协调 (`swarm-coordinator`)
- **一句话描述**: 协调多个代理完成复杂任务
- **核心命令**: `/swarm <任务描述>`
- **立即尝试**: `/swarm "简单多步骤任务"`

## 第一个小时学习计划

### 0-15分钟: 安装和设置
1. 安装所有技能 ✓
2. 验证安装成功 ✓
3. 浏览技能目录结构

### 15-30分钟: 学习基础技能
1. 详细阅读 `memory-review` 的 SKILL.md
2. 理解记忆层概念
3. 学习基本命令和选项

### 30-45分钟: 第一次实践
1. 运行 `memory-review --dry-run`
2. 查看分析报告
3. 理解提出的建议

### 45-60分钟: 扩展学习
1. 尝试 `kairos-lite` 创建定时任务
2. 学习 `verification-gate` 基本验证
3. 计划下一步学习

## 常见问题快速解答

### Q: 安装后技能不工作？
A: 检查：
1. 技能目录是否正确安装
2. OpenClaw 版本是否支持
3. 是否有必要的权限

### Q: 应该先学哪个技能？
A: 推荐顺序：
1. `memory-review` (最实用)
2. `kairos-lite` (最易用)
3. `verification-gate` (提高质量)
4. 其他技能按需学习

### Q: 技能间如何配合？
A: 典型配合：
- 用 `kairos-lite` 定期运行 `memory-review`
- 用 `verification-gate` 检查 `swarm-coordinator` 结果
- 用 `dream-memory` 自动整理 `style-extractor` 学习的数据

### Q: 需要多少时间掌握所有技能？
A: 建议计划：
- 基础掌握: 1-2周 (每天30分钟)
- 熟练使用: 1个月
- 精通应用: 2-3个月

## 立即行动清单

### 今天完成（第一天）
- [ ] 安装所有技能
- [ ] 验证安装成功
- [ ] 学习 `memory-review` 基础
- [ ] 运行一次测试审查
- [ ] 阅读 `kairos-lite` 简介

### 本周完成（第一周）
- [ ] 掌握 `memory-review` 所有功能
- [ ] 学会使用 `kairos-lite` 创建任务
- [ ] 理解 `verification-gate` 基本概念
- [ ] 尝试技能间简单配合
- [ ] 记录学习心得和问题

### 本月目标（第一个月）
- [ ] 熟练使用前4个技能
- [ ] 理解所有7个技能的概念
- [ ] 能解决常见使用问题
- [ ] 开始在实际任务中应用
- [ ] 分享学习经验

## 学习技巧

### 高效学习法
1. **20分钟专注学习** + **5分钟休息**
2. **先实践**后理论，遇到问题再查文档
3. **记录问题**和解决方案，建立知识库
4. **定期复习**，巩固学习成果

### 实践优先
不要等待完全理解再开始：
1. 立即安装和尝试
2. 从简单命令开始
3. 观察结果和反馈
4. 逐步增加复杂度

### 问题驱动学习
遇到问题时：
1. 明确问题现象
2. 查看相关文档
3. 尝试简单解决方案
4. 记录解决过程

## 获取帮助

### 自助资源
```bash
# 查看技能文档
cat /path/to/skill/SKILL.md

# 查看示例文件
ls /path/to/skill/*.example 2>/dev/null

# 查看日志
tail -f /root/.openclaw/workspace/logs/*.log
```

### 诊断工具
```bash
# 运行安装验证
cd /path/to/skill-learning-package
./verify-installation.sh

# 查看系统状态
./check-system.sh
```

### 社区支持
- OpenClaw 官方文档
- 技能使用论坛
- 开发者社区
- 问题跟踪系统

## 下一步行动

### 选择你的学习路径：

#### 路径A: 系统化学习（推荐）
1. 按 `LEARNING-GUIDE.md` 的8周计划学习
2. 每天固定时间学习30-60分钟
3. 完成所有实践任务
4. 定期评估学习进度

#### 路径B: 按需学习
1. 先学习最急需的技能
2. 在实际任务中边用边学
3. 遇到问题再学习相关技能
4. 逐步扩展技能范围

#### 路径C: 探索式学习
1. 浏览所有技能文档
2. 尝试感兴趣的功能
3. 发现自己的使用模式
4. 创造新的应用方式

### 立即开始：
```bash
# 1. 安装
cd /path/to/skill-learning-package
./install-all.sh

# 2. 打开 OpenClaw
# 3. 尝试第一个命令
# /memory-review --dry-run
```

**不要等待完美时机，现在就是最好的开始时间！**

每个技能都设计为渐进式学习，你可以从最简单的功能开始，逐步探索更高级的特性。学习过程中遇到的问题都是正常的学习过程，记录它们，解决它们，你会越来越熟练。

祝你学习愉快！ 🚀