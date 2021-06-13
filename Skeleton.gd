extends KinematicBody2D


onready var _animation_player = $AnimationPlayer

var health : int = 0
var dead : bool = false
var attacking: bool = false

const GRAVITY : int = 100
var SPEED : int = 100
const FLOOR = Vector2(0,-1)

var direction = 1
var state_machine
var vel : Vector2 = Vector2()

onready var ui = get_node("/root/Main Scene/CanvasLayer/UI")

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	state_machine.start("walk")	
	health = 10
func _physics_process(delta):
	
	
	if direction == -1:
		$Sprite.flip_h = true
		$"Player Detector/CollisionShape2D".position.x =-13.825
		$"HitBox/CollisionShape2D".position.x=-15.311
		
	else:
		$Sprite.flip_h = false
		$"Player Detector/CollisionShape2D".position.x =13.825
		$"HitBox/CollisionShape2D".position.x=15.311
		#$"Player Detector/CollisionShape2D".position.x
	if dead == true:
		SPEED = 0
		
	if attacking == true:
		SPEED = 0
	else:
		SPEED =100
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
	if area.get_name() == "Sword Hit":
		print(health)
		if health >0:
			state_machine.travel("hit")
			health-=1
		else:
			state_machine.travel("death")
			_animation_player.play("death")
			dead = true
			
			get_tree().root.get_node("Main Scene").get_node("Player").score +=1
			print(get_tree().root.get_node("Main Scene").get_node("Player").score)
			ui.setScore(get_tree().root.get_node("Main Scene").get_node("Player").score)
			
	pass
func hit():
	$HitBox.monitoring= true
	
func endOfHit():
	$HitBox.monitoring=false		
		

func die():
	queue_free()



func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'death':
		queue_free()
		print("number of skeletons:")
		print(get_tree().get_nodes_in_group("enemies").size()-1)
		ui.setEnemyNum(get_tree().get_nodes_in_group("enemies").size()-1)
		if((get_tree().get_nodes_in_group("enemies").size()-1)==0):
			ui.setWinMessage()


func _on_Player_Detector_body_entered(body):
	if(body.get_name() == "Player"):
		attacking = true
		state_machine.travel("attack")
	
		
	#while(body.get_name() == "Player"):
	#	attacking = true
	#	state_machine.travel("attack")
	#	yield(get_tree(),"idle_frame")
	

func _on_HitBox_body_entered(body):
	#print(get_tree().root.get_node("Main Scene").get_node("Player").hp)
	pass


func _on_Player_Detector_body_exited(body):
	if(body.get_name() == "Player"):
		attacking = false
		state_machine.travel("walk")
			
	
		
