extends KinematicBody

signal game_over
signal score_change


export var SPEED          = 14.0
export var JUMP_IMPULSE   = 20
export var GRAVITY        = 75
export var BOUNCE_IMPULSE = 16


var velocity = Vector3.ZERO




func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("move_up"):
		direction.z -= 1
	if Input.is_action_pressed("move_down"):
		direction.z += 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(translation + direction, Vector3.UP)
		$AnimationPlayer.playback_speed = 4
		$AnimationPlayer.play("float")
	else:
		$AnimationPlayer.play("RESET")

	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED

	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y += JUMP_IMPULSE

	velocity.y -= GRAVITY * delta
	velocity = move_and_slide(velocity, Vector3.UP)

	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("enemy"):
			var mob = collision.collider
			if Vector3.UP.dot(collision.normal) > .1:
				mob.squash()
				emit_signal("score_change")
				velocity.y = BOUNCE_IMPULSE

	$Pivot.rotation.x = PI / 6 * velocity.y / JUMP_IMPULSE




func init():
	$CollisionShape.disabled = false




func die():
	emit_signal("game_over")
	$CollisionShape.disabled = true
	hide()



func _on_HitDetector_body_entered(_body):
	die()
