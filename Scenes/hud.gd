extends CanvasLayer

@export var scoreLabel: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.score_changed.connect(_on_score_change)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_score_change(score:int) -> void:
	scoreLabel.text = str(score)
	pass
