class_name Camera_shake
extends Camera2D

var trauma: float = 0.0
var decay: float = 1
var max_offset: float = 40

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.player_life_changed.connect(_on_life_change)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if trauma >= 0:
		trauma -= decay*delta
	
	offset =Vector2(
		randf_range(-max_offset,max_offset), 
		randf_range(-max_offset,max_offset)) * trauma
	offset.x = clamp(offset.x,-max_offset,max_offset)
	offset.y = clamp(offset.y,-max_offset,max_offset)
	pass
func add_trauma(newTrauma: float) -> void:
	if trauma <= 1:
		trauma += newTrauma
	pass
	
func _on_life_change(life: int) -> void:
	if life == 0:
		trauma = 1
	else:
		trauma += 0.6
	pass
