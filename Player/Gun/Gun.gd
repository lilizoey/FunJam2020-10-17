extends Node2D

const BULLET: PackedScene = preload("res://Player/Gun/Bullet.tscn")

func _ready():
	pass # Replace with function body.


func _process(delta):
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("fire"):
		pass
		#fire()

func fire():
	var bullet = BULLET.instance()
	bullet.global_position = $Sprite.global_position
	bullet.rotation = rotation
	get_parent().get_world().add_child(bullet)
