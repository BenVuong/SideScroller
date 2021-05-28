extends KinematicBody2D


onready var _animation_player = $AnimationPlayer

var health : int = 0
var dead : bool = false

const GRAVITY : int = 100
var SPEED : int = 100
const FLOOR = Vector2(0,-1)

var direction = 1
var state_machine
var vel : Vector2 = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	state_machine.start("walk")	
	health = 10
	
	
	
func _physics_process(delta):
	if direction == -1:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false
	if dead == true:
		SPEED = 0
	vel.x = SPEED * direction
	#state_machine.travel("walk")
	vel.y += GRAVITY
	vel = move_and_slide(vel, FLOOR)
	
	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x *= -1
	
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		$RayCast2D.position.x *= -1



func _on_hurtbox_area_entered(area):
	if health > 0:
		state_machine.travel("hit")
		print(health)
		health -= 1
	elif dead == false:
		state_machine.travel("death")
		dead = true
		
		
		



func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'death':
		queue_free()
