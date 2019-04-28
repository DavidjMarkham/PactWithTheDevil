extends Area2D

var health = 100
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
	self.position.x = self.position.x + moveVector.x * ENEMY_1_BASE_MOVE_SPEED * delta
	self.position.y = self.position.y + moveVector.y * ENEMY_1_BASE_MOVE_SPEED * delta
	
	$enemyEye.look_at(player.position)
	
	if(fire_delay_timer>0):
		fire_delay_timer = fire_delay_timer - delta
	if(fire_delay_timer<=0):
		self._fire_default()
		
func _fire_default():
	self.fire_delay_timer = rand_range(min_fire_delay,max_fire_delay)
				
	var aimVector = Vector2(player.position.x - self.position.x, player.position.y - self.position.y)
	aimVector = aimVector.normalized()	
	
	
	
	self.bulletController.fire_bullet($Hole_South.global_position,1,aimVector)
	#self.bulletController.fire_bullet($Hole_SouthEast.global_position,1,aimVector)
	
		
	

func spawn(inputPos):
	self.in_use = true
	self.visible = true
	self.position = inputPos
	self.fire_delay_timer = rand_range(min_fire_delay,max_fire_delay)
	$CollisionShape2D.set_disabled(false)
	
func hit(dmg):
	self.health = self.health - 100
	if(self.health <= 0):
		self.dead()
	
func dead():
	$CollisionShape2D.call_deferred("set_disabled", true)
	self.enemyController.active_enemies = self.enemyController.active_enemies - 1
	self.in_use = false
	self.visible = false
	