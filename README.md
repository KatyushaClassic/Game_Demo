# 飞船爬塔 Roguelike（Godot + GDScript）

这是一个“组装飞船 + 爬塔”的 Roguelike 原型方案仓库，目标体验：

- **大地图**参考《杀戮尖塔》：4 层，层层有 Boss。
- **战斗操作**参考《远行星号》：WASD 机动、鼠标指向武器朝向、技能快捷键与可点击按钮。
- **组装系统**：通过拼接方块构建飞船，支持武器组、自动开火、特殊方块冲突与联动。
- **成长系统**：局外评分升级，解锁新的核心/方块。

## 当前内容

本仓库目前提供：

1. 需求拆解后的系统设计文档（`docs/gdd.md`）
2. 一套可落地的 Godot GDScript 系统骨架（`scripts/`）

## 推荐开发顺序

1. 先实现 `ShipBuilder` + `BlockData` 的可视化拼装。
2. 接入 `WeaponGroupManager`，打通输入与自动开火。
3. 实现 `MapGenerator` 跑通四层流程。
4. 补齐 `SynthesisSystem` 与 `MetaProgression` 的数据驱动配置。

## 目录结构

- `docs/gdd.md`：完整系统设计
- `docs/newbie_step_by_step.md`：新手逐步实作（节点挂载 + Resource 数据）
- `scripts/data/block_data.gd`：方块基础数据定义
- `scripts/systems/ship_builder.gd`：飞船拼装与合法性校验
- `scripts/systems/weapon_group_manager.gd`：武器组与自动开火控制
- `scripts/systems/special_module_manager.gd`：特殊方块被动/主动与冲突处理
- `scripts/systems/map_generator.gd`：四层大地图节点生成
- `scripts/systems/synthesis_system.gd`：战斗外合成
- `scripts/systems/meta_progression.gd`：局外评分成长

## 引擎版本建议

- Godot 4.x
- 语言：GDScript

## 环境配置

- 如果你是 **Windows** 开发者，不需要切换到 Ubuntu。
- 先按 `docs/setup_environment.md` 完成 Godot 4 环境配置，再执行一键检查脚本。

```bash
bash tools/check_godot_env.sh
```

