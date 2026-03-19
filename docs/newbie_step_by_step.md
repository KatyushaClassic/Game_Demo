# 新手一步一步实作指南（节点挂载 + Resource 数据）

这份文档专门回答两个问题：

1. **每个脚本应该挂在哪个节点上？**
2. **数据如何用 Resource 存储？**

---

## 1. 脚本与节点对应表（你可以照抄）

| 脚本 | 类型 | 推荐挂载节点 | 作用 |
|---|---|---|---|
| `scripts/systems/ship_builder.gd` | 系统脚本 | `Node`（如 `ShipBuilderSystem`） | 管理拼装占格、连通性校验 |
| `scripts/systems/weapon_group_manager.gd` | 系统脚本 | `Node`（如 `WeaponSystem`） | 武器组切换、自动开火 |
| `scripts/systems/special_module_manager.gd` | 系统脚本 | `Node`（如 `SpecialSystem`） | 特殊方块冲突和条件校验 |
| `scripts/systems/map_generator.gd` | 系统脚本 | `Node`（如 `MapSystem`） | 生成每层地图房间布局 |
| `scripts/systems/synthesis_system.gd` | 系统脚本 | `Node`（如 `CraftSystem`） | 按配方合成 |
| `scripts/systems/meta_progression.gd` | 系统脚本 | `Node`（如 `MetaSystem`） | 局外评分和升级解锁 |
| `scripts/data/block_data.gd` | 数据脚本 | 不挂场景（Resource） | 方块定义 |
| `scripts/data/weapon_group_data.gd` | 数据脚本 | 不挂场景（Resource） | 武器组定义 |
| `scripts/data/recipe_data.gd` | 数据脚本 | 不挂场景（Resource） | 合成配方定义 |
| `scripts/data/meta_level_data.gd` | 数据脚本 | 不挂场景（Resource） | 局外成长等级配置 |
| `scripts/data/floor_config_data.gd` | 数据脚本 | 不挂场景（Resource） | 地图楼层配置 |

> 重点：**系统脚本挂 Node，配置数据都做成 Resource（`.tres`）**。

---

## 2. 第一步：创建管理场景（Main）

1. 新建场景，根节点用 `Node`，命名 `Main`。
2. 在 `Main` 下依次创建子节点：
   - `ShipBuilderSystem`
   - `WeaponSystem`
   - `SpecialSystem`
   - `MapSystem`
   - `CraftSystem`
   - `MetaSystem`
3. 分别挂脚本：
   - `ShipBuilderSystem` 挂 `ship_builder.gd`
   - `WeaponSystem` 挂 `weapon_group_manager.gd`
   - `SpecialSystem` 挂 `special_module_manager.gd`
   - `MapSystem` 挂 `map_generator.gd`
   - `CraftSystem` 挂 `synthesis_system.gd`
   - `MetaSystem` 挂 `meta_progression.gd`

---

## 3. 第二步：创建 Resource 数据文件

在 Godot 文件系统中，建议建目录：`res://data/`，并创建：

- `BlockData` 资源（多个）
- `WeaponGroupData` 资源（多个）
- `RecipeData` 资源（多个）
- `MetaLevelData` 资源（多个）
- `FloorConfigData` 资源（每层一个或多个）

### 3.1 示例：创建一个方块

1. 右键 `res://data/blocks/` -> New Resource。
2. 选择 `BlockData`。
3. 保存为 `cannon_basic.tres`。
4. 填写字段：
   - `id = "cannon_basic"`
   - `block_type = TURRET`
   - `rarity = COMMON`
   - `size = (1,1)`
   - `tags = ["cannon"]`

### 3.2 示例：创建一个合成配方

1. New Resource -> `RecipeData`。
2. 保存为 `recipe_legendary_gun.tres`。
3. 设置：
   - `recipe_id = "legendary_gun_01"`
   - `inputs = {"cannon_basic": 2, "missile_basic": 1}`
   - `output_block_id = "cannon_legendary"`

---

## 4. 第三步：把 Resource 喂给系统脚本

你可以在一个引导脚本里加载资源后调用系统接口：

```gdscript
# 示例：把多个武器组资源交给 WeaponGroupManager
var weapon_groups: Array[WeaponGroupData] = [
	load("res://data/weapons/group_1.tres"),
	load("res://data/weapons/group_2.tres")
]
$WeaponSystem.set_groups(weapon_groups)
```

```gdscript
# 示例：把配方资源交给 SynthesisSystem
var recipes: Array[RecipeData] = [
	load("res://data/recipes/recipe_a.tres"),
	load("res://data/recipes/recipe_b.tres")
]
$CraftSystem.set_recipes(recipes)
```

```gdscript
# 示例：地图生成
var floor_cfg: FloorConfigData = load("res://data/map/floor_1.tres")
var grid: Array = $MapSystem.generate_floor(floor_cfg)
print(grid)
```

---

## 5. 第四步：先跑最小可玩闭环（建议顺序）

1. 拼装界面：先只做 1x1 方块放置。
2. 战斗界面：先实现 WASD + 一个武器组开火。
3. 地图流程：先随机房间，不做复杂事件。
4. 合成：先做 2~3 个测试配方。
5. 局外成长：先做 3 级升级表。

---

## 6. 新手最常见坑

1. **把 Resource 脚本挂到节点上**（这是错的）
   - Resource 只做数据，不进场景树。
2. **系统脚本里硬编码大量字典**
   - 你已经改成 Resource 方案，后面尽量都从 `.tres` 读。
3. **改了武器却没同步武器组**
   - 在改装 UI 退出时强制弹窗确认武器组。
4. **不做基础校验**
   - 拼装前先 `can_place_block`，合成前先 `can_synthesize`。


## 7. 现成示例资源（建议先打开看）

项目已经提供了 5 个可直接查看的示例方块资源：

- `res://resources/examples/blocks/example_cover_block.tres`
- `res://resources/examples/blocks/example_turret_block.tres`
- `res://resources/examples/blocks/example_thruster_block.tres`
- `res://resources/examples/blocks/example_core_block.tres`
- `res://resources/examples/blocks/example_special_block.tres`

并且每个主场景右侧都挂了一个“示例方块卡片”，会自动读取对应的 `BlockData`：

- `main_menu.tscn` -> 核心示例
- `systems_scene.tscn` -> 掩体示例
- `map_scene.tscn` -> 推进器示例
- `battle_scene.tscn` -> 炮塔示例
- `meta_scene.tscn` -> 特殊方块示例

你可以先运行项目，点进各场景，看看一份 `BlockData` 资源是如何被 UI 读取并展示的。
