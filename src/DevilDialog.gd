extends Control

var devilText
var options3
var option1Text
var option2Text
var option3Text
var devilSkitText
var curSkitIndex
var playingDevilPart1a = false
var playingDevilPart1b = false
var waitForInputTimer = 1
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
	self.option1Text = get_node("/root/DialogueScene/Options3/dialogPlayer1/Label")	
	self.option2Text = get_node("/root/DialogueScene/Options3/dialogPlayer2/Label")	
	self.option3Text = get_node("/root/DialogueScene/Options3/dialogPlayer3/Label")	
	
	self._startSkit1()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Ugly way to flow through dialogue skits, but it works
	if(self.playingDevilPart1a):
		if(self.waitForInputTimer > 0):
			self.waitForInputTimer = self.waitForInputTimer - delta
			
		if(self.gotoNextTimer > 0):
			self.gotoNextTimer = self.gotoNextTimer - delta
					
		if(self.gotoNextTimer<=0 || (Input.is_mouse_button_pressed(BUTTON_LEFT) && self.waitForInputTimer<=0)):
			self.curSkitIndex = self.curSkitIndex + 1
			if(self.curSkitIndex<self.devilSkitText.size()):
				self.devilText.text = self.devilSkitText[self.curSkitIndex]
				self.waitForInputTimer = 1
				self.gotoNextTimer = 6
			else:
				self.playingDevilPart1a = false
				self.playingDevilPart1b = true
				self._showOptions3()
	#elif(self.playingDevilPart1b):
		
			

func _startSkit1():
	self.devilSkitText = [	"Hey, I'm the devil. \nI'm lookin' for some souls \nto steal.",
							"You see, I'm in a bind, \nway behind, I'm willing\n to make a deal.",
							"You shoot a pretty good gun\n son,but give the Devil\n my due.",
							"I'll bet some sweet loot,\n against your soul,",
							"'cause I think some random \nalien dudes are better\n than you."]
	self._playSkit()
	
func _playSkit():
	self.playingDevilPart1a = true
	self.curSkitIndex = 0	
	self.devilText.text = self.devilSkitText[0]
	self.waitForInputTimer = .5
	self.gotoNextTimer = 4
	
func _showOptions3():
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
	
func _on_dialogPlayer1_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		if(self.playingDevilPart1b):
			self.donePart1b()

func _on_dialogPlayer2_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		if(self.playingDevilPart1b):
			self.donePart1b()


func _on_dialogPlayer3_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		if(self.playingDevilPart1b):
			self.donePart1b()


func donePart1b():
	get_tree().change_scene("res://scenes/World.tscn")