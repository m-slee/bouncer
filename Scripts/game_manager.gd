extends Node

var current_score = 0
var best_score = 0

@onready var current_score_label = $CanvasLayer/CurrentScore
@onready var best_score_label = $CanvasLayer/BestScore

@onready var spike_pit_area = $SpikePit/Area2D

var ball_initial_position = Vector2(586, 76)

const BALL_SCENE = preload("res://Scenes/ball.tscn")

func increment_score(amount):
	current_score += amount 
	current_score_label.text = "Current: " + str(current_score)

func reset():
	await get_tree().process_frame

	if current_score > best_score:
		best_score = current_score
		best_score_label.text = "Best: " + str(best_score)

	current_score = 0
	current_score_label.text = "Current: 0"

	# reset ball
	var ball_instance = BALL_SCENE.instantiate()
	ball_instance.global_position = ball_initial_position
	ball_instance.name = "Ball"

	spike_pit_area.body_entered.connect(ball_instance._on_area_2d_body_entered)

	# reconnect spikepit body_entered signal to new ball's handler
	call_deferred("add_child", ball_instance)
