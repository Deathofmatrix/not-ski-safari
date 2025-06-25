extends Node2D
class_name TerrainManager

@export var world_speed: float = 150.0

@export var terrain_segments: Array[TerrainSegment] = []

var camera_x: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta):
	# Move camera reference point
	camera_x += world_speed * delta
	
	# Move all terrain segments
	for segment in terrain_segments:
		segment.position.x -= world_speed * delta
