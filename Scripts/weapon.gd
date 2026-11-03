class_name Weapon
extends Node2D

@export var bullet_scene: PackedScene
@export var time_between_shots: float = 0.5
@export var sound: AudioStreamPlayer2D
var timer: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if timer >= time_between_shots:
		shoot()
		sound.pitch_scale = randf()
		sound.play()
		timer = 0
	pass

func shoot() -> void:
	var bullet: Node2D = bullet_scene.instantiate()
	bullet.global_position = global_position
	get_tree().current_scene.add_child(bullet)
	pass
