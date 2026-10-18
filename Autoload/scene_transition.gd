extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect

func fade_to_scene(target_scene_path: String) -> void:
	color_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	
	var tween = create_tween()
	tween.tween_property(color_rect, "modulate:a", 1.0, 0.5)
	await tween.finished
	
	get_tree().change_scene_to_file(target_scene_path)
	
	var fade_in = create_tween()
	fade_in.tween_property(color_rect, "modulate:a", 0.0, 0.5)
	await fade_in.finished
	
	color_rect.mouse_filter = Control.MOUSE_FILTER_STOP
