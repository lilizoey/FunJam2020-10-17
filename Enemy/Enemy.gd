extends KinematicBody2D

export var player_path: NodePath
onready var player: Player = get_node(player_path)

export var floor_path: NodePath
onready var _floor: Floor = get_node(floor_path)

var next_point = null
var move_speed: float = 60.0
var resolved_hits: Dictionary = {}
var move_direction = null

var clean_time: float = 0.25
var clean_timer: float = clean_time


var health: int = 500

func _ready():
	randomize()

func _physics_process(delta):
	resolved_hits = {}
	if not move_direction:
		move_direction = new_direction()
	clean_timer -= delta
	
	if clean_timer <= 0:
		clean_timer = clean_time
		_floor.clean_global(global_position)
	
	if abs(move_direction.y) > abs(move_direction.x):
		if move_direction.y > 0:
			$AnimatedSprite.animation = "down"
		else:
			$AnimatedSprite.animation = "up"
	else:
		if move_direction.x > 0:
			$AnimatedSprite.animation = "right"
		else:
			$AnimatedSprite.animation = "left"
	
	move_and_slide(move_direction * move_speed)
	
	if is_on_wall():
		move_direction = null
		return
	
	for i in get_slide_count():
		var collider = get_slide_collision(i).collider
		hit(collider)

func new_direction() -> Vector2:
	var angle = rand_range(-PI, PI)
	return Vector2(cos(angle), sin(angle))


func hit(obj: Object):
	if not resolved_hits.has(obj):
		resolved_hits[obj] = true
		if obj is PlayerBullet:
			take_damage(obj.damage())

func take_damage(damage: int):
	print("ow! ", health)
	health -= damage
