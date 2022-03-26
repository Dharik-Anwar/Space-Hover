extends RayCast2D

#If clear explaination needed
#Source : https://www.youtube.com/watch?v=dg0CQ6NPDn8
class_name Laser

#signal
signal hit

#variable
var is_casting := false setget set_is_casting


#Ready function
func _ready() -> void:
	set_physics_process(false)
	$Line2D.points[1] = Vector2.ZERO


#Physice process function: activate only if the laser is firing
func _physics_process(delta: float) -> void:
	var cast_point := cast_to
	force_raycast_update()
	$CollisionParticles2D.emitting = is_colliding()
	if is_colliding():
		cast_point = to_local(get_collision_point())
		$CollisionParticles2D.global_rotation = get_collision_point().angle()
		$CollisionParticles2D.position = cast_point
		$CollisionParticles2D.process_material.emission_box_extents.y = $Line2D.width * 0.5
		emit_signal("hit")
	$Line2D.points[1] = cast_point
	$BeamParticles2D.position = cast_point * 0.5
	$BeamParticles2D.process_material.emission_box_extents.x = cast_point.length() * 0.5


#set the casting
func set_is_casting(value: bool) -> void:
	is_casting = value
	$BeamParticles2D.emitting = is_casting 
	$CastParticles2D.emitting = is_casting
	if is_casting:
		$Line2D.width = 10.0
		$AudioStreamPlayer.play()
	else:
		$Line2D.width = 0.0
		$AudioStreamPlayer.stop()
		$CollisionParticles2D.emitting = false
	set_physics_process(is_casting)
