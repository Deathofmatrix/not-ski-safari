extends Node2D
class_name TerrainManager

@export var world_speed: float = 150.0
@export var slope_offset: float = 0.4

@export var terrain_segments: Array[TerrainSegment] = []

var camera_x: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta):
	
	for segment in terrain_segments:
		segment.position.x -= world_speed * delta
		segment.position.y -= world_speed * slope_offset * delta
