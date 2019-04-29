extends Control

var timer = 4
var waitForInputTimer = .5

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.play(0)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(timer >0):
		timer = timer - delta
	if(waitForInputTimer >0):
		waitForInputTimer = waitForInputTimer - delta
		
	if(timer<=0 || (Input.is_mouse_button_pressed(BUTTON_LEFT) && self.waitForInputTimer<=0)):
		get_tree().change_scene("res://scenes/MainMenu.tscn")

