class_name Enemy

extends Area2D

@export var speed: float = 200.0
@export var y_limit: float = 800.0
var velocity: Vector2 = Vector2.DOWN
var life: int = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	position += velocity * speed  * delta
	
	if position.y > y_limit:
		queue_free()
	pass
	
func take_damage(amount: int) -> void:
	life -= amount
	if life == 0:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is Player:
		area.take_damage(1)
		take_damage(2)
	if area is Bullet:
		area.destroy()
		take_damage(1)
		
	pass # Replace with function body.
