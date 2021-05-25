extends Camera2D


onready var player = get_node("/root/Main Scene/Player")

func _process(delta):
	position.x = player.position.x
