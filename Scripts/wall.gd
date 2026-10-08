extends Node


@onready var bumper_sound_player = $"../../../BumperSoundPlayer"

func _on_body_entered(body:Node2D) -> void:
	if body.name == "Ball":
		bumper_sound_player.play()
