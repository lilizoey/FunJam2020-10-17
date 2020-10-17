extends KinematicBody2D

export var player_path: NodePath
onready var player: Player = get_node(player_path)

export var floor_path: NodePath
onready var _floor: Floor = get_node(floor_path)

var next_point = null
var move_speed: float = 120.0
var move_distance: float = 160.0
var resolved_hits: Dictionary = {}

var health: int = 500

func _ready():
	randomize()

func _physics_process(delta):
	resolved_hits = {}
	if not next_point:
		next_point = new_point()
	
	var direction: Vector2 = (next_point - global_position).normalized()
	move_and_slide(direction * move_speed)
	
	for i in get_slide_count():
		var collider = get_slide_collision(i).collider
		hit(collider)
	
	if is_on_wall() or (next_point - global_position).length() <= move_speed * delta * 2:
		next_point = null


func new_point() -> Vector2:
	var angle = rand_range(-PI, PI)
	var direction = Vector2(cos(angle), sin(angle))
	var point = direction * rand_range(0, move_distance)
	
	$Ray.cast_to = point
	$Ray.force_raycast_update()
	
	if $Ray.get_collision_point():
		return $Ray.get_collision_point()
	else:
		return global_position + point


func hit(obj: Object):
	if not resolved_hits.has(obj):
		resolved_hits[obj] = true
		if obj is PlayerBullet:
			take_damage(obj.damage())

func take_damage(damage: int):
	print("ow! ", damage)
	health -= damage
