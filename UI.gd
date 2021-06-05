extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var scoreNum = get_node("ScoreNum")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setScore(score):
	scoreNum.text = str(score)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
