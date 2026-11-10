class_name Enemy

extends Area2D

@export var speed: float = 200.0
@export var y_limit: float = 800.0
@export var sprite: Sprite2D
@export var timer: Timer
@export var explotion_fx: PackedScene
@export var debris_scene: PackedScene

@export var knockback_force: float = 400
@export var knockback_recovery: float = 2000

@export var score_point: int = 1

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
		death()


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

func death() -> void:
	var explosion: Node2D = explotion_fx.instantiate()
	explosion.global_position = global_position
	var debris: Node2D = debris_scene.instantiate()
	debris.global_position = global_position
	GameManager.add_score(score_point)
	var camera: Camera_shake = get_viewport().get_camera_2d() as Camera_shake
	if camera:
		camera.add_trauma(0.25)
	GameManager.hitstop(0.04)
	get_tree().current_scene.add_child(explosion)
	get_tree().current_scene.add_child(debris)
	queue_free()
	pass
