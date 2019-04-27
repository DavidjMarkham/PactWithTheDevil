extends Area2D

const PLAYER_SPEED = 100
var bulletController
var fire_delay_timer = 0
var FIRE_DELAY = .25

# Called when the node enters the scene tree for the first time.
func _ready():
	self.bulletController = get_node("/root/World/BulletController")	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if(fire_delay_timer>0):
		fire_delay_timer = fire_delay_timer - delta
	
	# Have player look at mouse position
	var mpos = get_viewport().get_mouse_position()
	$playerSprite.look_at(mpos) 
		 
	if(Input.is_key_pressed(KEY_UP) || Input.is_key_pressed(KEY_W)):
		self.position.y = self.position.y - PLAYER_SPEED * delta
	if(Input.is_key_pressed(KEY_DOWN) || Input.is_key_pressed(KEY_S)):
		self.position.y = self.position.y + PLAYER_SPEED * delta
	if(Input.is_key_pressed(KEY_LEFT) || Input.is_key_pressed(KEY_A)):
        self.position.x = self.position.x - PLAYER_SPEED * delta
	if(Input.is_key_pressed(KEY_RIGHT) || Input.is_key_pressed(KEY_D)):
        self.position.x = self.position.x + PLAYER_SPEED * delta
		
	if(Input.is_mouse_button_pressed(BUTTON_LEFT) && fire_delay_timer<=0):		
		fire_delay_timer = FIRE_DELAY
		self.bulletController.fire_bullet($playerSprite/GunBarrel.global_position,0,$playerSprite.rotation)
		
		