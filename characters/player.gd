extends CharacterBody2D

# Constants
const GRAVITY = 2000.0
const MAX_SPEED = 800.0
const JUMP_FORCE = -800.0

func _physics_process(delta):
	if is_on_floor():
		# Get the slope's normal
		var floor_normal = get_floor_normal()

		# Project gravity along the slope (downhill direction)
		var downhill_direction = ProjectSettings.get_setting("physics/2d/default_gravity_vector").normalized().slide(floor_normal).normalized()
		var slope_acceleration = downhill_direction * GRAVITY

		# Add slope acceleration to velocity
		velocity += slope_acceleration * delta

		# Jumping
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_FORCE
	else:
		# Apply vertical gravity in air
		velocity.y += GRAVITY * delta

	# Cap max speed (optional)
	if velocity.length() > MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED

	# Move the character
	move_and_slide()
