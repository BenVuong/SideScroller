extends Camera2D


onready var player = get_node("/root/Main Scene/Player")

func _process(delta):
	position.x = player.position.x
	if player.position.y < 700:
		position.y = player.position.y
