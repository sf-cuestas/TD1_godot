class_name Enemy

extends Area2D

@export var speed: float = 200.0
@export var y_limit: float = 800.0
@export var sprite: Sprite2D
@export var timer: Timer
@export var explotion_fx: PackedScene

@export var knockback_force: float = 400
@export var knockback_recovery: float = 2000

var velocity: Vector2 = Vector2.DOWN
var life: int = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2.DOWN * speed
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

func _physics_process(delta: float) -> void:
	var target_velocity: Vector2 = Vector2.DOWN * speed
	velocity = velocity.move_toward(target_velocity, knockback_recovery*delta)
	position += velocity * delta
	
	if position.y > y_limit:
		queue_free()
	pass
	
func take_damage(amount: int) -> void:
	life -= amount
	if life == 0:
		var explosion: Node2D = explotion_fx.instantiate()
		explosion.global_position = global_position
		get_tree().current_scene.add_child(explosion)
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is Player:
		area.take_damage(1)
		take_damage(2)
	if area is Bullet:
		area.destroy()
		take_damage(1)
	sprite.modulate = Color(10,10,10)
	timer.start()
	velocity = Vector2.UP * knockback_force
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	sprite.modulate = Color.WHITE
	pass # Replace with function body.
