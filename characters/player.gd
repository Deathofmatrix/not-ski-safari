extends RigidBody2D
class_name CharacterController

var is_grounded: bool = false
var ground_normal: Vector2 = Vector2.UP
var target_position: Vector2

@export var collision_detector : RayCast2D

func _ready() -> void:
	continuous_cd = RigidBody2D.CCD_MODE_CAST_RAY
	
	target_position = Vector2(-200, 0)
	position = target_position


func _process(delta):
	# Keep player roughly in the same screen position
	# Allow some movement but pull back to target
	var pull_strength = 2.0
	var offset = position - target_position
	
	if abs(offset.x) > 50:  # Only pull if too far from target
		apply_central_impulse(Vector2(-offset.x * pull_strength, 0))


func _physics_process(delta):
	check_ground_contact()
	#handle_rotation(delta)


func check_ground_contact():
	# Use a raycast or area to detect ground
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(
		global_position,
		global_position + Vector2(0, 30)
	)
	query.exclude = [self]
	
	var result = space_state.intersect_ray(query)
	
	if result:
		is_grounded = true
		ground_normal = result.normal
	else:
		is_grounded = false
		ground_normal = Vector2.UP

#func handle_rotation(delta):
	#var target_rotation = 0.0
	#
	#if is_grounded:
		## Align with slope
		#target_rotation = ground_normal.angle() - PI/2
		#target_rotation = clamp(target_rotation, -deg_to_rad(max_rotation), deg_to_rad(max_rotation))
	#else:
		## Air control based on input
		#if Input.is_action_pressed("rotate_left"):
			#target_rotation = -deg_to_rad(max_rotation)
		#elif Input.is_action_pressed("rotate_right"):
			#target_rotation = deg_to_rad(max_rotation)
	#
	## Smoothly rotate to target
	#rotation = lerp_angle(rotation, target_rotation, rotation_speed * delta)


func _integrate_forces(state):
	# Apply slight forward momentum to simulate skiing
	if is_grounded:
		var slope_direction = Vector2(ground_normal.y, -ground_normal.x)
		state.apply_central_force(slope_direction * 100)
