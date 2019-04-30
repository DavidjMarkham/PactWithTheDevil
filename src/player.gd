extends Area2D

const PLAYER_SPEED = 100
var bulletController
var fire_delay_timer = 0
var FIRE_DELAY = .4
var health = 100
var BASE_HEALTH = 100
var camera

# Called when the node enters the scene tree for the first time.
func _ready():
	self.bulletController = get_node("/root/World/BulletController")	
	self.camera = get_node("/root/World/Camera2D")	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):		
	if(fire_delay_timer>0):
		fire_delay_timer = fire_delay_timer - delta
	
	# Have player look at mouse position
	var mpos = get_global_mouse_position()
	
	$playerSprite.look_at(mpos) 
	var linear_vel = Vector2(0,0)
		 
	if(Input.is_key_pressed(KEY_UP) || Input.is_key_pressed(KEY_W)):
		linear_vel.y = -1
	if(Input.is_key_pressed(KEY_DOWN) || Input.is_key_pressed(KEY_S)):
		linear_vel.y = 1
	if(Input.is_key_pressed(KEY_LEFT) || Input.is_key_pressed(KEY_A)):
        linear_vel.x = -1
	if(Input.is_key_pressed(KEY_RIGHT) || Input.is_key_pressed(KEY_D)):
        linear_vel.x = 1
		
	if(self.position.x > 3000 && linear_vel.x>0):
		linear_vel.x = 0
	if(self.position.x < -3000 && linear_vel.x<0):
		linear_vel.x = 0
	if(self.position.y > 1000 && linear_vel.y>0):
		linear_vel.y = 0
	if(self.position.y < -1000 && linear_vel.y<0):
		linear_vel.y = 0
	
		
	if(linear_vel != Vector2(0,0)):
		linear_vel.normalized()
		self.position.x = self.position.x + linear_vel.x * PLAYER_SPEED * delta * Global.player_speed_multipler
		self.position.y = self.position.y + linear_vel.y * PLAYER_SPEED * delta * Global.player_speed_multipler
		self.camera.position = self.position
		
	if(Input.is_mouse_button_pressed(BUTTON_LEFT) && fire_delay_timer<=0):		
		fire_delay_timer = FIRE_DELAY * 1 / Global.player_fire_rate_multipler 
		self.bulletController.fire_bullet($playerSprite/GunBarrel.global_position,0,$playerSprite.rotation)
		if(Global.player_has_spread_shot || Global.player_has_super_spread_shot):
			self.bulletController.fire_bullet($playerSprite/GunBarrel.global_position,0,$playerSprite.rotation+PI/12)
			self.bulletController.fire_bullet($playerSprite/GunBarrel.global_position,0,$playerSprite.rotation-PI/12)
		if(Global.player_has_super_spread_shot):
			self.bulletController.fire_bullet($playerSprite/GunBarrel.global_position,0,$playerSprite.rotation+PI/12 * 2)
			self.bulletController.fire_bullet($playerSprite/GunBarrel.global_position,0,$playerSprite.rotation-PI/12 * 2)
		

func hit(dmg):
	self.health = self.health - 100
	$playerSprite/AnimationPlayer.play("Hit")

func hitDone():
	# Only remove enemy after animation plays
	if(self.health <= 0):
		self.dead()
	
func dead():
	$CollisionShape2D.call_deferred("set_disabled", true)
	self.visible = false
	get_tree().change_scene("res://scenes/GameOver.tscn")
	
		