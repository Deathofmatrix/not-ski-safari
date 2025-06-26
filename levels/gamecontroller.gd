extends Node2D
class_name GameController

@export var world_speed: float = 150.0
@export var speed_increase_rate: float = 2.0
@export var max_speed: float = 400.0

var current_speed: float
var game_time: float = 0.0
var is_game_active: bool = true

@export var terrain_manager: TerrainManager
@export var player: CharacterBody2D
@export var camera: Camera2D


func _ready():
	current_speed = world_speed

func _process(delta):
	if not is_game_active:
		return
		   
	game_time += delta
	
	# Gradually increase speed over time
	current_speed = min(world_speed + (game_time * speed_increase_rate), max_speed)
	
	# Update terrain movement
	terrain_manager.world_speed = current_speed
	
	camera.position.y = player.position.y
	
	print(camera.position.distance_to(Vector2.ZERO))
	
	if camera.position.distance_to(Vector2.ZERO) > 1000:
		reposition_world(camera.position * -1)


func reposition_world(value: Vector2):
	camera.position -= value
	player.position -= value
