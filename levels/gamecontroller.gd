extends Node2D
class_name GameController

@export var world_speed: float = 150.0
@export var speed_increase_rate: float = 2.0
@export var max_speed: float = 400.0

var current_speed: float
var game_time: float = 0.0
var is_game_active: bool = true

@export var terrain_manager: TerrainManager
@export var player: RigidBody2D
@export var camera: Camera2D


func _ready():
	current_speed = world_speed
	camera.position = Vector2(200, 0)

func _process(delta):
	if not is_game_active:
		return
		   
	game_time += delta
	
	# Gradually increase speed over time
	current_speed = min(world_speed + (game_time * speed_increase_rate), max_speed)
	
	# Update terrain movement
	terrain_manager.world_speed = current_speed
