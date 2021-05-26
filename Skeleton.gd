extends KinematicBody2D


onready var _animation_player = $AnimationPlayer
var health : int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	_animation_player.play("idle")
	health = 10
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_hurtbox_area_entered(area):
	if health > 0:
		_animation_player.play("hit")
	
		

	
