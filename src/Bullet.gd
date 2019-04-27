extends Area2D

var in_use=true
var BULLET_SPEED = 500
var linear_vel = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!in_use):
		return
			
	self.position.x = self.position.x + self.linear_vel.x * BULLET_SPEED * delta
	self.position.y = self.position.y + self.linear_vel.y * BULLET_SPEED * delta
	
	if(	self.position.x < -100 || \
		self.position.x >1920 || \
		self.position.y < -100 || \
		self.position.y > 2020):
			self.in_use = false
			self.visible =false
	
	
func spawn(inputPos,inputRotation):
	self.position = inputPos
	self.rotation = inputRotation
	self.visible = true
	self.in_use = true
	#determine linear_velocity based on x and y components
	self.linear_vel = Vector2(cos(self.rotation),sin(self.rotation))