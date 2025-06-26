extends CharacterBody2D
class_name CharacterController

var is_grounded: bool = false
var ground_normal: Vector2 = Vector2.UP

@export var collision_detector : ShapeCast2D


func _process(delta):
	pass


func _physics_process(delta):
	check_ground_contact()
	
	if not is_grounded:
		velocity += get_gravity() * delta
	
	velocity.x = 0
	
	rotation = lerp_angle(rotation, ground_normal.angle() + PI/2, 10 *delta) 
	
	move_and_slide()


func check_ground_contact():
	var ground_collisions: Array = collision_detector.get_collision_result()
	
	if ground_collisions.size() > 0:
		is_grounded = true
		ground_normal = ground_collisions[0].normal

	else:
		is_grounded = false


func _integrate_forces(state):
	if is_grounded:
		var slope_direction = Vector2(ground_normal.y, -ground_normal.x)
		state.apply_central_force(slope_direction * 100)
