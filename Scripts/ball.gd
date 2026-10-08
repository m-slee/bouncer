extends RigidBody2D

@onready var game_manager = $"../"

@export var impulse_size = 200
@export var y_impulse = -600

var mouse_in_boundary = false

@onready var pop_sound_player = $"../PopSoundPlayer"
@onready var click_sound_player = $"../ClickSoundPlayer"

func _ready() -> void:
	input_pickable = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		if mouse_in_boundary:
			click_sound_player.play()
			game_manager.increment_score(1)

			var mouse_pos = get_global_mouse_position()

			# y component is constant, x component is based on angle of click
			var angle = get_click_angle(mouse_pos)
			apply_impulse(
				Vector2(
					-impulse_size*cos(angle), 
					y_impulse
				)
			)

func get_click_angle(mouse_pos):
	# compute angle between x-axis and vector of click relative to center of ball
	var x_axis = Vector2(1, 0)
	var click_vector = Vector2(mouse_pos.x - global_position.x, global_position.y - mouse_pos.y)

	# formula for computing angle between two vectors
	return acos(
		x_axis.dot(click_vector) / (x_axis.length() * click_vector.length())
	)


func _on_mouse_exited() -> void:
	mouse_in_boundary = false


func _on_mouse_entered() -> void:
	mouse_in_boundary = true

func _on_area_2d_body_entered(_body: Node2D) -> void:
	pop_sound_player.play()
	queue_free()
	game_manager.reset()
