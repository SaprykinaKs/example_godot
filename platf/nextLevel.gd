extends Node2D

@export var next_scene : String

func _on_go_to_next_scene_body_entered(body: Node2D):
	if body.name != "Player":
		return
	get_tree().change_scene_to_file(next_scene)

func _ready():
	if $portal:
		$portal.animation = "default"  # Устанавливаем анимацию "default"
		$portal.play()                # Запускаем анимацию
