extends CharacterBody2D
class_name Demon

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var fire = false
var attack = false
var health = 75
var cooldown = true
const fireballInstance = preload("res://scenes/fireball.tscn")

func _physics_process(delta: float) -> void:
	
	$Control/HealthBar.value = health
	
	if health <= 0:
		$Control/HealthBar.visible = false
		$AnimationPlayer.play("dying")
		$DyingMusic.play()
		await get_tree().create_timer(1).timeout
		queue_free()
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if attack:
		cooldown = false
		velocity.x = 0
		$AnimationPlayer.play("attacking")
		await get_tree().create_timer(0.6).timeout
		cooldown = true
		get_parent().get_parent().get_node("Chicken").health -= 0.1
		
	else:
		velocity.x = 0
		$AnimationPlayer.play("idle")
	
	move_and_slide()

func _on_attack_trigger_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.name == "Chicken":
			attack = true


func _on_attack_trigger_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.name == "Chicken":
			attack = false


func _on_fire_trigger_body_entered(body: Node2D) -> void:
	if body is Chicken:
		while cooldown:
			cooldown = false
			$FireballMarker.look_at(body.global_position)
			var fireball = fireballInstance.instantiate()
			fireball.rotation = $FireballMarker.rotation
			get_parent().add_child(fireball)
			fireball.global_position = $FireballMarker.global_position
			await get_tree().create_timer(1).timeout
			cooldown = true
