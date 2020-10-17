class_name PlayerBullet
extends KinematicBody2D

export var bullet_speed: float = 400.0

func _ready():
	pass # Replace with function body.

func _process(delta):
	move_and_slide(Vector2(bullet_speed,0).rotated(rotation))
	if get_slide_count() > 0:
		queue_free()
	
	for i in get_slide_count():
		if get_slide_collision(i).collider.has_method("hit"):
			get_slide_collision(i).collider.hit(self)

func damage() -> int:
	return 10
