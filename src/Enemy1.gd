extends Area2D

var health = 100
var ENEMY_BASE_HEALTH = 100
var in_use = true
var player
var bulletController
var enemyController
var ENEMY_1_BASE_MOVE_SPEED = 100
var fire_delay_timer = 0
var min_fire_delay = 2
var max_fire_delay = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/World/Player")
	self.bulletController = get_node("/root/World/EnemyBulletController")	
	self.enemyController = get_node("/root/World/EnemyController")	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!self.in_use):
		return
		
		
	# Move towards player
	var moveVector = Vector2(player.position.x - self.position.x, player.position.y - self.position.y)
	moveVector = moveVector.normalized()
	self.position.x = self.position.x + moveVector.x * ENEMY_1_BASE_MOVE_SPEED * delta * Global.enemy_move_speed_multiplier
	self.position.y = self.position.y + moveVector.y * ENEMY_1_BASE_MOVE_SPEED * delta * Global.enemy_move_speed_multiplier
	
	$enemyEye.look_at(player.position)
	
	if(fire_delay_timer>0):
		fire_delay_timer = fire_delay_timer - delta
	if(fire_delay_timer<=0):
		if(randi() %2<1):
			self._fire_default()
		else:
			self._fire_alt()
		
func _fire_default():
	self.fire_delay_timer = rand_range(min_fire_delay,max_fire_delay) * 1 / Global.enemy_fire_rate_multiplier
	
	# Aim for player			
	#var aimVector = Vector2(player.position.x - self.position.x, player.position.y - self.position.y)
	#aimVector = aimVector.normalized()	

	
	self.bulletController.fire_bullet($Hole_East.global_position,1,self.rotation)
	self.bulletController.fire_bullet($Hole_West.global_position,1,self.rotation+PI)
	self.bulletController.fire_bullet($Hole_North.global_position,1,self.rotation-PI/2)
	self.bulletController.fire_bullet($Hole_South.global_position,1,self.rotation+PI/2)
	
func _fire_alt():
	self.fire_delay_timer = rand_range(min_fire_delay,max_fire_delay) * 1 / Global.enemy_fire_rate_multiplier
		
	self.bulletController.fire_bullet($Hole_NorthEast.global_position,1,self.rotation-PI/4)
	self.bulletController.fire_bullet($Hole_NorthWest.global_position,1,self.rotation-PI/4*3)
	self.bulletController.fire_bullet($Hole_SouthEast.global_position,1,self.rotation+PI/4)
	self.bulletController.fire_bullet($Hole_SouthWest.global_position,1,self.rotation+PI/4*3)
	

func spawn(inputPos):
	self.in_use = true
	self.visible = true
	self.position = inputPos
	self.fire_delay_timer = rand_range(min_fire_delay,max_fire_delay)
	self.health = self.ENEMY_BASE_HEALTH * Global.enemy_armor_multiplier
	$CollisionShape2D.set_disabled(false)
	
func hit(dmg):
	self.health = self.health - 100
	$enemyBase/AnimationPlayer.play("Hit")

func hitDone():
	# Only remove enemy after animation plays
	if(self.health <= 0):
		self.dead()
	
func dead():
	$CollisionShape2D.call_deferred("set_disabled", true)
	self.enemyController.active_enemies = self.enemyController.active_enemies - 1
	self.in_use = false
	self.visible = false
	