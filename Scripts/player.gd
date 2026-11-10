class_name Player
extends Area2D

@export var speed: float = 600.0
@export var x_limit: float = 360.0
@export var y_limit: float = 600.0
@export var acceleration: float = 4000
@export var max_rotation: float = 30
@onready var sprite: Sprite2D = $Sprite2D
@onready var invisibility_timer: Timer = $InvisibilityTimer
var is_invisibility: bool = false
@export var hurt_sound: AudioStreamPlayer2D
@export var explotion_fx: PackedScene
var velocity: Vector2 = Vector2.ZERO
var life: int = 3


func _ready() -> void:
	
	pass # une fois, quand le nœud apparaît
	
func _process(delta: float) -> void:
	pass

	
func _physics_process(delta: float) -> void:
	var target_velocity: Vector2 = read_direction() * speed

	velocity = velocity.move_toward(target_velocity, acceleration * delta)
	position += velocity  * delta
	position.x = clamp(position.x,-x_limit,x_limit)
	position.y = clamp(position.y,-y_limit,y_limit)
	sprite.rotation = deg_to_rad(max_rotation) * (velocity.x / speed)
	
func read_direction() -> Vector2:
	var direction : Vector2 = Vector2.ZERO
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")

	if Input.is_action_pressed("touch"):
		var destination: Vector2 = get_global_mouse_position()
		var x_distance_to_finger : float = destination.x - position.x
		var y_distance_to_finger : float = destination.y - position.y
		direction.x = clamp(x_distance_to_finger/60, -1,1)
		direction.y = clamp(y_distance_to_finger/60, -1,1)

	
	return direction

func take_damage(amount: int) -> void:
	if is_invisibility:
		return
	is_invisibility = true
	invisibility_timer.start()
	var blink_tween: Tween = get_tree().create_tween()
	blink_tween.tween_property(sprite,"modulate:a", 0.1, 0.1)
	blink_tween.tween_property(sprite,"modulate:a", 1, 0.1)
	blink_tween.set_loops(5)
	blink_tween.play()
	life -= amount
	hurt_sound.play()
	GameManager.hitstop(0.1)
	if life <= 0:
		var explosion: Node2D = explotion_fx.instantiate()
		explosion.global_position = global_position
		explosion.scale = Vector2.ONE*2
		get_tree().current_scene.add_child(explosion)
		GameManager.trigger_game_over()
		
	GameManager.player_life_change(life)
	pass


func _on_invisibility_timer_timeout() -> void:
	is_invisibility = false
	pass # Replace with function body.
