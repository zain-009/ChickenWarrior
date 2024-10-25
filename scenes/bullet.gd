extends Area2D

var speed = 800
var velocity = Vector2.ZERO

func _ready():
	velocity = Vector2.RIGHT.rotated(rotation) * speed

func _process(delta):
	position += velocity * delta
	
func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body is Demon:
			body.health -= 5
			queue_free()
	elif body is CollisionPolygon2D or CollisionShape2D:
		queue_free()
