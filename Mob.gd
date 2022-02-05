extends KinematicBody

export var MIN_SPEED = 8.0
export var MAX_SPEED = 14.0

signal squashed




var velocity = Vector3.ZERO




func _physics_process(_delta):
	move_and_slide(velocity)




func _ready():
	randomize()
	var spawn_location  = $SpawnPath/SpawnLocation
	spawn_location.unit_offset = randf()
	var player_position = get_parent().get_node("Player").transform.origin

	translation = spawn_location.translation
	look_at(player_position, Vector3.UP)
	rotate_y(rand_range(-PI / 4, PI / 4))
	rotate_z(0)

	var speed = rand_range(MIN_SPEED, MAX_SPEED)
	velocity = Vector3.FORWARD * speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)

	$AnimationPlayer.playback_speed = 4 * speed / MIN_SPEED
	$AnimationPlayer.play("float")




func squash():
	emit_signal("squashed")
	queue_free()




func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()
