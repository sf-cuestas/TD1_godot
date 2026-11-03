extends Area2D

@export var speed: float = 600.0
var direction: Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	direction = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down", ))
	var velocity : Vector2 = direction.normalized() * speed
	position += velocity * delta
	transform.translated(position)
	pass
