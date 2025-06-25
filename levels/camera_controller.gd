extends Camera2D
class_name CameraController

@export var target: Node2D  # Assign your player in the inspector
@export var follow_speed: float = 5.0
@export var vertical_offset: float = -50.0  # Offset to show more terrain ahead
@export var horizontal_offset: float = 200.0  # Keep player on left side
@export var smoothing_enabled: bool = true

var target_position: Vector2

func _ready():
	# If no target assigned, try to find the player
	if not target:
		target = get_node("../CharacterController")  # Adjust path as needed
	
	# Enable smoothing in Godot's camera system
	if smoothing_enabled:
		position_smoothing_enabled = true
		position_smoothing_speed = follow_speed

func _process(delta):
	if not target:
		return
	
	# Calculate target camera position
	target_position = Vector2(
		target.global_position.x + horizontal_offset,
		target.global_position.y + vertical_offset
	)
	
	if smoothing_enabled:
		# Let Godot handle the smoothing
		global_position = target_position
	else:
		# Manual smoothing
		global_position = global_position.lerp(target_position, follow_speed * delta)
