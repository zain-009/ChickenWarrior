extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VictoryMusic.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")
"res://assets/music/ingame.mp3"

func _on_quit_pressed() -> void:
	get_tree().quit()
