extends Control

var timer = 4
var waitForInputTimer = .5

# Called when the node enters the scene tree for the first time.
func _ready():
	var roundMessage = get_node("/root/EndRoundScene/Label")	
	roundMessage.text = "Round " + str(Global.cur_round-1) + " Completed!"	
	if(Global.accepted_bet):
		self.show_reward()
		
	# Reset handicaps
	Global.enemy_armor_multiplier = 1
	Global.enemy_move_speed_multiplier = 1
	Global.enemy_fire_rate_multiplier = 1
	Global.enemy_spawn_rate = 1
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(timer >0):
		timer = timer - delta
	if(waitForInputTimer >0):
		waitForInputTimer = waitForInputTimer - delta
		
	if(timer<=0 || (Input.is_mouse_button_pressed(BUTTON_LEFT) && self.waitForInputTimer<=0)):
		if(	Global.cur_round == 2 || \
			Global.cur_round == 5 || \
			Global.cur_round == 8 || \
			Global.cur_round == 11 || \
			Global.cur_round == 14 || \
			Global.cur_round == 17 || \
			Global.cur_round == 20):
				get_tree().change_scene("res://scenes/DevilDialog.tscn")
		else:
			get_tree().change_scene("res://scenes/World.tscn")


func show_reward():
	$Reward.visible = true
	Global.accepted_bet = false
		
	if(Global.cur_round==3):		
		Global.player_armor_multipler = Global.player_armor_multipler * 1.5
		$Reward/BetRewardSprite.frame = 0
	elif(Global.cur_round==6):		
		Global.player_speed_multipler = Global.player_speed_multipler * 1.5
		$Reward/BetRewardSprite.frame = 1
	elif(Global.cur_round==9):		
		Global.player_fire_rate_multipler = Global.player_fire_rate_multipler * 1.5
		$Reward/BetRewardSprite.frame = 2
	elif(Global.cur_round==12):		
		Global.player_has_spread_shot = true
		$Reward/BetRewardSprite.frame = 3
	elif(Global.cur_round==15):		
		Global.player_armor_multipler = Global.player_armor_multipler * 1.5
		$Reward/BetRewardSprite.frame = 4
	elif(Global.cur_round==18):		
		Global.player_speed_multipler = Global.player_speed_multipler * 1.5
		$Reward/BetRewardSprite.frame = 5
	elif(Global.cur_round==21):		
		Global.player_fire_rate_multipler = Global.player_fire_rate_multipler * 1.5
		$Reward/BetRewardSprite.frame = 6