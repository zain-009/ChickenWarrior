extends Area2D

var SPEED = 400
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2.RIGHT.rotated(rotation).normalized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocity * SPEED * delta

func _on_body_entered(body: Node2D) -> void:
	if body is Chicken:
		body.health -= 10
		queue_free()
	elif body is CollisionPolygon2D or CollisionShape2D:
		queue_free()


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
