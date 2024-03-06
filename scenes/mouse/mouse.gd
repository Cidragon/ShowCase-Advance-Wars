extends Node2D

@onready var cursor: Sprite2D = %cursor

var is_unit_selected : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_unit_selected:
		var grid_position : Vector2i = Vector2i(get_global_mouse_position() / Main.TILE_SIZE)
		
		position = Vector2(grid_position) * Main.TILE_SIZE

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click") and is_unit_selected == false:
		var grid_position : Vector2i = Vector2i(get_global_mouse_position() / Main.TILE_SIZE)
		#print(grid_position)
		var unit : Unit = get_parent().units.get(grid_position)
		#print(unit)
		if unit:
			is_unit_selected = true
			print("there is a unit")
			unit.show_walkable_tiles()
	elif event.is_action_pressed("left_click") and is_unit_selected == false:
		print("move character")
		pass
	elif event.is_action_pressed("right_click"):
		is_unit_selected = false
