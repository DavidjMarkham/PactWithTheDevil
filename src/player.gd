extends Area2D

const PLAYER_SPEED = 100
var bulletController

# Called when the node enters the scene tree for the first time.
func _ready():
	self.bulletController = get_node("/root/World/BulletController")	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
		
	if(Input.is_mouse_button_pressed(BUTTON_LEFT)):
        self.bulletController.fire_bullet($playerSprite/GunBarrel.global_position,0,$playerSprite.rotation)
		