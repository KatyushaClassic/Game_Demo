extends Node
class_name WeaponGroupManager

# 武器组开火信号：战斗系统监听后执行实际发射
signal group_fired(group_id: int)

# 武器组数据表：key=group_id, value=WeaponGroupData
var groups: Dictionary = {}

# 当前玩家主控武器组
var active_group: int = 1

# 设置单个武器组（推荐从 Resource 载入后调用）
func set_group(group_data: WeaponGroupData) -> void:
	groups[group_data.group_id] = group_data

# 批量设置武器组
func set_groups(group_list: Array[WeaponGroupData]) -> void:
	groups.clear()
	for g in group_list:
		set_group(g)

# 切换玩家主控组
func switch_group(group_id: int) -> void:
	if groups.has(group_id):
		active_group = group_id

# 修改自动开火开关
func set_auto_fire(group_id: int, enabled: bool) -> void:
	var group_data: WeaponGroupData = groups.get(group_id)
	if group_data != null:
		group_data.auto_fire = enabled

# 玩家触发开火
func request_player_fire() -> void:
	if not groups.has(active_group):
		return
	emit_signal("group_fired", active_group)

# AI 自动开火轮询（返回本次应触发的组）
func tick_ai_auto_fire(should_fire: bool) -> Array[int]:
	var fired_groups: Array[int] = []
	if not should_fire:
		return fired_groups

	for id in groups.keys():
		if id == active_group:
			continue
		var group_data: WeaponGroupData = groups[id]
		if group_data.auto_fire:
			fired_groups.append(id)
	return fired_groups
