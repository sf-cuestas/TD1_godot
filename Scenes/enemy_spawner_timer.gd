class_name Enemy_spawner_timer
extends Timer

@export var enemy_scene: PackedScene

var x_limit: float = 320.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_timeout() -> void:
	var enemy: Node2D = enemy_scene.instantiate()
	enemy.global_position = Vector2(randf_range(-x_limit,x_limit), -840)
	get_tree().current_scene.add_child(enemy)
	print("Fin du timer")
	pass # Replace with function body.
