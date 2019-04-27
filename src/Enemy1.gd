extends Area2D

var health = 100
var in_use = true
var player
var ENEMY_1_BASE_MOVE_SPEED = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/World/Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!self.in_use):
		return
	
	# Move towards player
	var moveVector = Vector2(player.position.x - self.position.x, player.position.y - self.position.y)
	moveVector = moveVector.normalized()
	self.position.x = self.position.x + moveVector.x * ENEMY_1_BASE_MOVE_SPEED * delta
	self.position.y = self.position.y + moveVector.y * ENEMY_1_BASE_MOVE_SPEED * delta
	
	

func spawn(inputPos):
	self.in_use = true
	self.visible = true
	self.position = inputPos
	$CollisionShape2D.set_disabled(false)
	
func hit(dmg):
	self.health = self.health - 100
	if(self.health <= 0):
		self.dead()
	
func dead():
	$CollisionShape2D.call_deferred("set_disabled", true)
	self.in_use = false
	self.visible = false
	