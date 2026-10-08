extends Node

@export var points = 1
@onready var game_manager = $"../../"
@onready var bumper_sound_player = $"../../BumperSoundPlayer"

func _on_area_2d_body_entered(body:Node2D) -> void:
	if body.name == "Ball":
		bumper_sound_player.play()
		game_manager.increment_score(points)
