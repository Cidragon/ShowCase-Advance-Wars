extends Node2D

@onready var cursor: Sprite2D = %cursor

var is_unit_selected : bool = false
var unit_selected : Vector2i
const DEFAULT_NO_UNIT : Vector2i = Vector2i(-1,-1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	unit_selected = DEFAULT_NO_UNIT
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_unit_selected:
		var grid_position : Vector2i = Vector2i(get_global_mouse_position() / Main.TILE_SIZE)
		
		position = Vector2(grid_position) * Main.TILE_SIZE

func is_inside_map(grid_position : Vector2i) -> bool:
	var x : int = grid_position.x
	var y : int = grid_position.y
	if x >= Main.MAP_SIZE.x or x < 0 or y >= Main.MAP_SIZE.y or y < 0:
		return false
	return true

func is_inside_walkable_area(grid_position: Vector2i) -> bool:
	if is_inside_map(grid_position):
		var unit : Unit = get_parent().units.get(unit_selected)
		if not unit:
			return false
		
		var distance_to_unit = unit.get_manhattan_distance(unit.grid_position, grid_position)
		if distance_to_unit <= unit.move_distance:
			return true
	
	return false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click") and is_unit_selected == false:
		var grid_position : Vector2i = Vector2i(get_global_mouse_position() / Main.TILE_SIZE)
		print("is inside map? :" , is_inside_map(grid_position))
		#print(grid_position)
		var unit : Unit = get_parent().units.get(grid_position)
		#print(unit)
		if unit:
			is_unit_selected = true
			unit_selected = grid_position
			print("there is a unit")
			unit.show_walkable_tiles()
	elif event.is_action_pressed("left_click") and is_unit_selected == true:
		print("move character")
		var grid_position : Vector2i = Vector2i(get_global_mouse_position() / Main.TILE_SIZE)
		print("is position walkable: " , is_inside_walkable_area(grid_position))
		pass
	elif event.is_action_pressed("right_click"):
		if unit_selected != DEFAULT_NO_UNIT:
			var unit : Unit = get_parent().units.get(unit_selected)
			unit.hide_walkable_tiles()
			unit_selected = DEFAULT_NO_UNIT
			
		is_unit_selected = false
