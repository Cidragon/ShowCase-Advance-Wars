extends Node2D
class_name Main

@export var unit_scene : PackedScene

const TILE_SIZE : Vector2 = Vector2(16,16)



var units: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_soldier()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func create_soldier() -> void:
	var soldier : Unit = unit_scene.instantiate()
	soldier.position = Vector2(320, 256)
	add_child(soldier)
	units[soldier.grid_position] = soldier
	print("soldier grid position: ", soldier.grid_position)
	
