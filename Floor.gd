class_name Floor
extends Node2D

var tiles: Array = []

export var tile_min: int = 0
export var tile_max: int = 0

func _ready():
	var cells = $Base.get_used_cells()
	var min_x
	var min_y
	var max_x
	var max_y
	for cell in cells:
		if not min_x or min_x > cell.x:
			min_x = cell.x
		if not max_x or max_x < cell.x:
			max_x = cell.x
		
		if not min_y or min_y > cell.y:
			min_y = cell.y
		if not max_y or max_y < cell.y:
			max_y = cell.y
	
	for x in range(min_x, max_y):
		tiles.append([])
		for y in range(min_y, max_y):
			tiles.append($Base.get_cell(x,y))
			if $Base.get_cell(x,y) != $Base.INVALID_CELL:
				$Dirt.set_cell(x, y, floor(rand_range(tile_min, tile_max)))

func _process(delta):
	pass

func clean(x: int, y: int):
	pass
