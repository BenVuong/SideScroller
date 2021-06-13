extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var scoreNum = get_node("ScoreNum")
onready var healthNum = get_node("HealthNum")
onready var enemiesNum = get_node("EnemiesNum")
onready var winMessage = get_node("Win Message")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setScore(score):
	scoreNum.text = str(score)
func setHealth(health):
	healthNum.text = str(health)
func setEnemyNum(num):
	enemiesNum.text = str(num)
func setWinMessage():
	winMessage.text="You Win!"
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
