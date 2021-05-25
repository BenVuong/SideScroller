extends KinematicBody2D




var score : int = 0

# physics
var speed : int = 200
var jumpForce : int = 400
var gravity : int = 800
var t = Timer.new()


var vel : Vector2 = Vector2()
var grounded : bool = false

onready var _animated_sprite = $AnimatedSprite


func _ready():
	_animated_sprite.play("Idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	vel.x = 0
	
	
	if Input.is_action_pressed("move_left"):
		vel.x -= speed
		_animated_sprite.play("Running")
	if Input.is_action_pressed("move_right"):
		vel.x += speed
		_animated_sprite.play("Running")
	if Input.is_action_pressed("attack"):
		_animated_sprite.play("Attack")
	
		
	vel = move_and_slide(vel, Vector2.UP)
	
	vel.y += gravity * delta
	
	if Input.is_action_pressed("jump") and is_on_floor():
		_animated_sprite.play("Jump")
		vel.y -= jumpForce
		
		
		
	if vel.x < 0:
		_animated_sprite.flip_h = false
	if vel.x > 0:
		_animated_sprite.flip_h = true
		
func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation != 'Idle':
		$AnimatedSprite.play('Idle')


