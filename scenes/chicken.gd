extends CharacterBody2D
class_name Chicken

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const bullet = preload("res://scenes/bullet.tscn")
var health = 75
var cooldown = true

func _physics_process(delta: float) -> void:
	
	$Control/HealthBar.value = health
	
	if health <= 0:
		get_tree().change_scene_to_file("res://scenes/GameOver.tscn")
	
	var mouse_pos = get_global_mouse_position()
	$PositionMarker.look_at(mouse_pos)
	$gun.look_at(mouse_pos)
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_pressed("fire") and cooldown:
		cooldown = false
		var bulletInstance = bullet.instantiate()
		bulletInstance.rotation = $PositionMarker.rotation
		get_parent().add_child(bulletInstance)
		bulletInstance.global_position = $PositionMarker.global_position
		$ShootSound.play()		
		await get_tree().create_timer(0.1).timeout
		cooldown = true
	
	var direction := Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = direction * SPEED
		$AnimationPlayer.play("running")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)
		if is_on_floor():
			$AnimationPlayer.stop()

	move_and_slide()
