extends Sprite2D
class_name Unit

@export var walkable_tile : Texture

var move_distance : int = 4
var grid_position : Vector2i
var is_selected : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grid_position = Vector2i(position / Main.TILE_SIZE)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_walkable_tiles() -> void:
	var walkable_tiles : Dictionary = get_walkable_tiles()
	walkable_tiles_to_sprites(walkable_tiles)

func get_walkable_tiles() -> Dictionary:
	var queue : Array[Vector2i] = [grid_position]
	var visited : Dictionary = {}
	
	while queue:
		#print(queue)
		var current : Vector2i = queue.pop_back()
		visited[current] = true
		
		var up_grid_position : Vector2i = current + Vector2i(0,-1)
		var is_distance_walkable : bool = get_manhattan_distance(grid_position, up_grid_position) <= move_distance
		if not visited.has(up_grid_position) and is_distance_walkable: 
			queue.push_back(up_grid_position)
			#print("not used UP")
		
		var right_grid_position : Vector2i = current + Vector2i(1,0)
		is_distance_walkable = get_manhattan_distance(grid_position, right_grid_position) <= move_distance
		if not visited.has(right_grid_position) and is_distance_walkable:
			queue.push_back(right_grid_position)
			#print("not used RIGHT")
		
		var down_grid_position : Vector2i = current + Vector2i(0,1)
		is_distance_walkable = get_manhattan_distance(grid_position, down_grid_position) <= move_distance
		if not visited.has(down_grid_position) and is_distance_walkable:
			queue.push_back(down_grid_position)
			#print("not used DOWN")
		
		var left_grid_position : Vector2i = current + Vector2i(-1,0)
		is_distance_walkable = get_manhattan_distance(grid_position, left_grid_position) <= move_distance
		if not visited.has(left_grid_position) and is_distance_walkable:
			queue.push_back(left_grid_position)
			#print("not used LEFT")
		
	
	print(visited)
	return visited

func walkable_tiles_to_sprites(tiles : Dictionary) -> void:
	for value in tiles:
		var new_sprite : Sprite2D = Sprite2D.new()
		new_sprite.z_index = 0
		new_sprite.z_as_relative = false
		new_sprite.centered = false
		new_sprite.texture = walkable_tile
		var new_grid_position : Vector2i = grid_position - value
		new_sprite.position = Vector2(new_grid_position) * Main.TILE_SIZE
		add_child(new_sprite)
		#print(new_sprite.position)
	pass

func hide_walkable_tiles():
	for child in get_children():
		child.queue_free()

func get_manhattan_distance(start : Vector2i, end: Vector2i):
	return abs(end.x - start.x) + abs(end.y - start.y)
