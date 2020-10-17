class_name Player
extends KinematicBody2D

export var world: NodePath
var mouse_position: Vector2 = Vector2(0,0)
var resolved_hits: Dictionary = {}

var running = false
var facing = "right"

func _ready():
	pass 

func _physics_process(delta):
	resolved_hits = {}
	
	var velocity = Vector2(0,0)
	
	var moving = false
	
	if Input.is_action_pressed("move_down"):
		velocity.y += PlayerVariables.PLAYER_SPEED
		moving = true
	if Input.is_action_pressed("move_up"):
		velocity.y -= PlayerVariables.PLAYER_SPEED
		moving = true
	
	if Input.is_action_pressed("move_right"):
		velocity.x += PlayerVariables.PLAYER_SPEED
		moving = true
	if Input.is_action_pressed("move_left"):
		velocity.x -= PlayerVariables.PLAYER_SPEED
		moving = true
	
	if velocity.x < 0:
		$AnimationPlayer.play("Turn Left")
	if velocity.x > 0:
		$AnimationPlayer.play("Turn Right")
	
	if moving and not running:
		$AnimationPlayer.play("Run")
		running = true
	elif not moving and running:
		$AnimationPlayer.play("Stop")
		running = false
	
	
	move_and_slide(velocity)

func hit(obj: Object):
	if not resolved_hits.has(obj):
		resolved_hits[obj] = true

func take_damage(damage: int):
	print("player be like, ow: ", damage)
	PlayerVariables.health -= damage

func die():
	pass

func get_world() -> Node:
	return get_node(world)
