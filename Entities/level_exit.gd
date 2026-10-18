extends Area2D

@export_file("*.tscn") var next_scene_path: String = ""

var is_transitioning: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not is_transitioning:
		if next_scene_path.is_empty():
			push_warning("请配置下一关的路径")
			return
			
		is_transitioning = true
		trigger_transition()
		
func trigger_transition() -> void:
	if SceneTransition.has_method("fade_to_scene"):
		SceneTransition.fade_to_scene(next_scene_path)
	else:
		get_tree().change_scene_to_file(next_scene_path)
		
