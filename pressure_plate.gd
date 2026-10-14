extends Area2D

signal plate_pressed
signal plate_released

var pressing_bodies: int = 0

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Seed" or body.name == "Player":
		pressing_bodies += 1
		if pressing_bodies == 1:
			plate_pressed.emit()
			
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Seed" or body.name == "Player":
		pressing_bodies -= 1
		if pressing_bodies == 0:
			plate_released.emit()
