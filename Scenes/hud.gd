extends CanvasLayer

@export var scoreLabel: Label
@export var lifeContainer: HBoxContainer
@export var gameOverContainer: Control
@export var damageFlash: ColorRect
var damageFlashTimer: float = 0.25 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.score_changed.connect(_on_score_change)
	GameManager.player_life_changed.connect(_on_life_change)
	gameOverContainer.visible = false
	scoreLabel.pivot_offset = scoreLabel.size / 2
	scoreLabel.text = "%06d" %0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_score_change(score:int) -> void:
	scoreLabel.text = "%06d" %score
	scoreLabel.scale = Vector2(1.4, 1.4)
	var changeSizeTween: Tween = get_tree().create_tween()
	changeSizeTween.tween_property(scoreLabel, "scale",Vector2.ONE, damageFlashTimer)
	changeSizeTween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	changeSizeTween.play()
	pass

func _on_life_change(life: int) -> void:
	damageFlash.color = Color(1.0,0,0, 0.4)
	var flashTween: Tween = get_tree().create_tween()
	flashTween.tween_property(damageFlash, "color", Color(1.0, 0, 0 , 0), damageFlashTimer)
	flashTween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	flashTween.play()
	
	for i: int in lifeContainer.get_child_count():
		lifeContainer.get_child(i).visible = i + 1 <= life
	if life == 0:
		gameOverContainer.visible = true
	pass


func _on_play_again_button_pressed() -> void:
	GameManager.restart()
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
