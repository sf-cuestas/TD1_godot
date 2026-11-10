extends Node

@export var globalScore: int = 0
var hit_stop_timer: SceneTreeTimer = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

signal score_changed(score: int)
signal player_life_changed(life: int)
signal game_over() 

func add_score(score: int) -> void:
	globalScore += score
	score_changed.emit(globalScore)
	
func player_life_change(life: int) -> void:
	player_life_changed.emit(life)
	if life == 0:
		trigger_game_over()
	
func trigger_game_over() -> void:
	get_tree().paused = true
	game_over.emit()
	
func restart() -> void:
	globalScore = 0
	get_tree().paused = false
	get_tree().reload_current_scene.call_deferred()
	
func hitstop(time: float) -> void:
	Engine.time_scale = time
	hit_stop_timer = get_tree().create_timer(0.1,true, false, true)
	hit_stop_timer.timeout.connect(hit_end)
	pass
	
func hit_end() -> void:
	Engine.time_scale = 1
	hit_stop_timer = null
