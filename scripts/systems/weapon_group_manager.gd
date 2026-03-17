extends Node
class_name WeaponGroupManager

# 当某个武器组被触发开火时发出信号，战斗系统可监听它并执行真正射击逻辑
signal group_fired(group_id: int)

# 使用 Resource 数据存储武器组：key=group_id, value=WeaponGroupData
var groups: Dictionary = {}

# 当前玩家主控武器组
var active_group: int = 1

# 初始化/更新武器组（推荐从 .tres 资源读入后调用）
func set_group(group_data: WeaponGroupData) -> void:
	groups[group_data.group_id] = group_data

# 批量载入武器组资源（方便新手一次性配置）
func set_groups(group_list: Array[WeaponGroupData]) -> void:
	groups.clear()
	for g in group_list:
		set_group(g)

# 切换当前玩家控制武器组
func switch_group(group_id: int) -> void:
	if groups.has(group_id):
		active_group = group_id

# 修改指定武器组自动开火设置
func set_auto_fire(group_id: int, enabled: bool) -> void:
	var group_data: WeaponGroupData = groups.get(group_id)
	if group_data != null:
		group_data.auto_fire = enabled

# 玩家主动点击/按键触发当前组开火
func request_player_fire() -> void:
	if not groups.has(active_group):
		return
	emit_signal("group_fired", active_group)

# 每帧/每tick调用一次：AI 负责除 active_group 外可自动开火的组
func tick_ai_auto_fire(should_fire: bool) -> Array[int]:
	var fired_groups: Array[int] = []
	if not should_fire:
		return fired_groups

	for id in groups.keys():
		# 当前主控组不交给 AI
		if id == active_group:
			continue
		var group_data: WeaponGroupData = groups[id]
		if group_data.auto_fire:
			fired_groups.append(id)
	return fired_groups
