extends Control

# Declare member variables here. Examples:
var blipSound

# Called when the node enters the scene tree for the first time.
func _ready():
	blipSound = get_node("/root/Control/AudioStreamPlayer2D")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ResumeButton_pressed():	
	$AudioStreamPlayer2D.play(0)
	# Wait for sound to play
	var t = Timer.new()
	t.set_wait_time(0.25)
	add_child(t)
	t.start()
	yield(t, "timeout")
	self.visible = false
	get_tree().paused = false

func _on_NewGameButton_pressed():
	$AudioStreamPlayer2D.play(0)
	# Wait for sound to play
	var t = Timer.new()
	t.set_wait_time(0.25)
	add_child(t)
	t.start()
	yield(t, "timeout")
	get_tree().paused = false
	
	# Reset Globals
	Global.cur_round = 1
	Global.accepted_bet = false
	Global.player_speed_multipler = 1
	Global.player_fire_rate_multipler = 1
	Global.player_armor_multipler = 1
	Global.player_has_spread_shot = false
	Global.player_has_super_spread_shot = false
	Global.enemy_armor_multiplier = 1
	Global.enemy_move_speed_multiplier = 1
	Global.enemy_fire_rate_multiplier = 1
	Global.enemy_spawn_rate = 1
	
	get_tree().change_scene("res://scenes/DevilDialog.tscn")


func _on_ExitGameButton_pressed():	
	$AudioStreamPlayer2D.play(0)
	# Wait for sound to play
	var t = Timer.new()
	t.set_wait_time(0.25)
	add_child(t)
	t.start()
	yield(t, "timeout")
	self.visible = false
	get_tree().quit()

func _on_MainMenuButton_pressed():	
	$AudioStreamPlayer2D.play(0)
	# Wait for sound to play
	var t = Timer.new()
	t.set_wait_time(0.25)
	add_child(t)
	t.start()
	yield(t, "timeout")
	get_tree().change_scene("res://scenes/MainMenu.tscn")


