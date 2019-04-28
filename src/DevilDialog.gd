extends Control

var devilText
var options2
var options3
var option1Text
var option2Text
var option3Text
var devilSkitText
var curSkitIndex
var playingDevilPart1a = false
var playingDevilPartPostReward = false
var playingReward = false
var waitForInputTimer = .5
var gotoNextTimer = 6

var randomResponses = [	"Okay...",
						"Shut it devil!",
						"Yep",
						"I'm the best\nthere's ever been!",
						"Bring it!",
						"Whatever...",
						"Let me show you\nhow its done!",
						"k"]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	self.devilText = get_node("/root/DialogueScene/devilDialog/Label")	
	self.options3 = get_node("/root/DialogueScene/Options3")	
	self.options2 = get_node("/root/DialogueScene/Options2")	
	self.option1Text = get_node("/root/DialogueScene/Options3/dialogPlayer1/Label")	
	self.option2Text = get_node("/root/DialogueScene/Options3/dialogPlayer2/Label")	
	self.option3Text = get_node("/root/DialogueScene/Options3/dialogPlayer3/Label")	
	
	self.options2.visible = false
	self.options3.visible = false
	$Reward.visible = false
	
	if(Global.cur_round == 1):
		self._startSkit1()
		
	elif(Global.cur_round >= 2):
		self._startSkit2()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(self.waitForInputTimer > 0):
		self.waitForInputTimer = self.waitForInputTimer - delta
		
	if(self.gotoNextTimer > 0):
		self.gotoNextTimer = self.gotoNextTimer - delta
	# Ugly way to flow through dialogue skits, but it works
	if(self.playingDevilPart1a || playingDevilPartPostReward):
		if(self.gotoNextTimer<=0 || (Input.is_mouse_button_pressed(BUTTON_LEFT) && self.waitForInputTimer<=0)):
			self.curSkitIndex = self.curSkitIndex + 1
			if(self.curSkitIndex<self.devilSkitText.size()):
				self.devilText.text = self.devilSkitText[self.curSkitIndex]
				self.waitForInputTimer = .5
				self.gotoNextTimer = 6
			else:
				self.playingDevilPart1a = false								
				if(Global.cur_round == 1 || self.playingDevilPartPostReward):
					self.playingDevilPartPostReward = false			
					self._showOptions3()
				else:
					self._showOptions2()
	elif(self.playingReward):
		if(self.gotoNextTimer<=0 || (Input.is_mouse_button_pressed(BUTTON_LEFT) && self.waitForInputTimer<=0)):
			$Reward.visible = false	
			$devilDialog.visible = true
			self.playingReward = false
			self.devilSkitText = [	"I'm still lookin' \nfor some souls \nto steal.",							
									"I'll make another bet \nfor some sweet loot, \nagainst your soul,",
									"'cause I think some random \nalien dudes are better \nthan you."]
			
			self.playingDevilPartPostReward = true
			self.curSkitIndex = 0	
			self.devilText.text = self.devilSkitText[0]
			self.waitForInputTimer = .5
			self.gotoNextTimer = 4
		
			

func _startSkit1():
	self.devilSkitText = [	"Hey, I'm the devil. \nI'm lookin' for some souls \nto steal.",
							"You see, I'm in a bind, \nway behind, I'm willing \nto make a deal.",
							"You shoot a pretty good gun \nson,but give the Devil \nmy due.",
							"I'll bet some sweet loot, \nagainst your soul,",
							"'cause I think some random \nalien dudes are better \nthan you."]
	self._playSkit()
	
func _startSkit2():
	self.devilSkitText = [	"Not bad, I know \nwhen I've been beat.",
							"But how 'bout we go \ndouble or nothing? \nI'm not bluffing.",
							"If you win you get \neven better loot.",
							"But if you lose, \nthe devil gets your soul." ]
	self._playSkit()
	
func _playSkit():
	self.playingDevilPart1a = true
	self.curSkitIndex = 0	
	self.devilText.text = self.devilSkitText[0]
	self.waitForInputTimer = .5
	self.gotoNextTimer = 4
	
func _showOptions3():
	self.waitForInputTimer = 1
	# Get 3 unique, random responses
	var response1 = randi() % self.randomResponses.size()
	var response2 = randi() % self.randomResponses.size()
	var response3 = randi() % self.randomResponses.size()
	while(response2 == response1):
		response2 = randi() % self.randomResponses.size()		
	while(response3 == response2 || response3 == response1):
		response3 = randi() % self.randomResponses.size()
	
	self.option1Text.text = self.randomResponses[response1]
	self.option2Text.text = self.randomResponses[response2]
	self.option3Text.text = self.randomResponses[response3]
	self.options3.visible = true
	
func _showOptions2():	
	$Options2/choiceAccept/BetRewardSprite.frame = Global.cur_round - 2
	$Options2/choiceReject/RewardSprite.frame = Global.cur_round - 2
	self.waitForInputTimer = 1
	self.options2.visible = true
	
func _on_dialogPlayer1_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed && self.waitForInputTimer<=0):
		self.startRound()

func _on_dialogPlayer2_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed && self.waitForInputTimer<=0):
		self.startRound()


func _on_dialogPlayer3_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed && self.waitForInputTimer<=0):
		self.startRound()

func startRound():
	self.options2.visible = false
	self.options3.visible = false
	get_tree().change_scene("res://scenes/World.tscn")
	
func _apply_handicap():
	if(Global.cur_round==2):		
		Global.enemy_armor_multiplier = 2
	elif(Global.cur_round==5):		
		Global.enemy_move_speed_multiplier = 2
	elif(Global.cur_round==8):		
		Global.enemy_fire_rate_multiplier = 1.5
	elif(Global.cur_round==11):		
		Global.enemy_spawn_rate = 1.5
	elif(Global.cur_round==14):		
		Global.enemy_armor_multiplier = 3
	elif(Global.cur_round==17):		
		Global.enemy_move_speed_multiplier = 3
	elif(Global.cur_round==20):		
		Global.enemy_fire_rate_multiplier = 2

func _on_choiceAccept_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed && self.waitForInputTimer<=0):
		# Start next round
		Global.accepted_bet = true
		self.options2.visible = false
		self.options3.visible = false
		self._apply_handicap()
		get_tree().change_scene("res://scenes/World.tscn")

func _on_choiceReject_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed && self.waitForInputTimer<=0):
		self._show_reward()
						
		
func _show_reward():
	self.options2.visible = false
	Global.accepted_bet = false
	
	self.waitForInputTimer = .5
	self.gotoNextTimer = 6
	
	$Reward.visible = true	
	if(Global.cur_round==2):		
		Global.player_armor_multipler = Global.player_armor_multipler * 1.5
		$Reward/RewardSprite.frame = 0
	elif(Global.cur_round==5):		
		Global.player_speed_multipler = Global.player_speed_multipler * 1.5
		$Reward/RewardSprite.frame = 1
	elif(Global.cur_round==8):		
		Global.player_fire_rate_multipler = Global.player_fire_rate_multipler * 1.5
		$Reward/RewardSprite.frame = 2
	elif(Global.cur_round==11):		
		Global.player_has_spread_shot = true
		$Reward/RewardSprite.frame = 3
	elif(Global.cur_round==14):		
		Global.player_armor_multipler = Global.player_armor_multipler * 1.5
		$Reward/RewardSprite.frame = 4
	elif(Global.cur_round==17):		
		Global.player_speed_multipler = Global.player_speed_multipler * 1.5
		$Reward/RewardSprite.frame = 5
	elif(Global.cur_round==20):		
		Global.player_fire_rate_multipler = Global.player_fire_rate_multipler * 1.5
		$Reward/RewardSprite.frame = 6
	
	$devilDialog.visible = false
	self.playingReward = true		