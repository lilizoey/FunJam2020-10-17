class_name Floor
extends Node2D

var tiles: Array = []

var min_x: int
var min_y: int
var max_x: int
var max_y: int

func _ready():
	var cells = $Base.get_used_cells()
	for cell in cells:
		if not min_x or min_x > cell.x:
			min_x = cell.x
		if not max_x or max_x < cell.x:
			max_x = cell.x
		
		if not min_y or min_y > cell.y:
			min_y = cell.y
		if not max_y or max_y < cell.y:
			max_y = cell.y
	
	for x in range(min_x, max_x + 1):
		var row = []
		tiles.append(row)
		for y in range(min_y, max_y + 1):
			row.append($Base.get_cell(x, y) != -1)

func _process(delta):
	pass

func clean(x: int, y: int):
	if is_clean(x, y):
		return
	pass

func is_clean(x: int, y: int) -> bool:
	if x < min_x or x > max_x:
		return true
	if y < min_y or y > max_y:
		return true

	return tiles[x - min_x][y - min_y];

func v_is_clean(position: Vector2) -> bool:
	return is_clean(floor(position.x + 0.5), floor(position.y + 0.5))
