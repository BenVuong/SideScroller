extends KinematicBody2D




var score : int = 0

# physics
var speed : int = 200
var jumpForce : int = 400
var gravity : int = 800
var t = Timer.new()
var state_machine
var hp : int = 20

var vel : Vector2 = Vector2()
var grounded : bool = false


onready var _animation_player = $AnimationPlayer
onready var ui = get_node("/root/Main Scene/CanvasLayer/UI")
onready var enemyNum = get_tree().get_nodes_in_group("enemies").size()




func _ready():
	#_animation_player.play("Idle")
	state_machine = $AnimationTree.get("parameters/playback")
	state_machine.start("Idle")
	hp = 20
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	vel.x = 0
	
	
	if Input.is_action_just_pressed("resetGame"):
		get_tree().reload_current_scene()
	
	if Input.is_action_pressed("move_left"):
		$Sprite.flip_h = false
		$"Sprite/Sword Hit".scale = Vector2(1,1)
		vel.x -= speed
		
	if Input.is_action_pressed("move_right"):
		$Sprite.flip_h = true
		$"Sprite/Sword Hit".scale = Vector2(-1,1)
		vel.x += speed
		
	if Input.is_action_pressed("test"):
		state_machine.travel("Hit")
	if Input.is_action_pressed("attack"):
		state_machine.travel("Attack")
		return
	
		
	vel = move_and_slide(vel, Vector2.UP)
	if vel.length() == 0:
		state_machine.travel("Idle")
	if vel.length() != 0:
		if vel.y < 0:
			state_machine.travel("Jump")
		else:	
			state_machine.travel("Running")
	
	vel.y += gravity * delta
	
	if Input.is_action_pressed("jump") and is_on_floor():
		state_machine.travel("Jump")
		vel.y -= jumpForce
		


func _on_Sword_Hit_area_entered(area):
	if area.is_in_group("hurtbox"):
		pass


func _on_PlayerHurtBox_area_entered(area):
	if area.get_name()=="HitBox":
		#print("ouch!")
		state_machine.travel("Hit")
		hp-=1
		ui.setHealth(hp)
