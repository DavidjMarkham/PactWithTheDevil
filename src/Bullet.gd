extends Area2D

var in_use=true
var BULLET_SPEED = 500
var linear_vel = Vector2(0,0)
var dmg = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!in_use):
		return
			
	self.position.x = self.position.x + self.linear_vel.x * BULLET_SPEED * delta
	self.position.y = self.position.y + self.linear_vel.y * BULLET_SPEED * delta
	
	if(	self.position.x < get_global_transform().get_origin().x - 2020 || \
		self.position.x >get_global_transform().get_origin().x + 2020 || \
		self.position.y < get_global_transform().get_origin().y - 1180 || \
		self.position.y > get_global_transform().get_origin().y + 1180):
			self.in_use = false
			self.visible =false
			$CollisionShape2D.set_disabled(true)

	
func spawn(inputPos,inputRotation):
	self.position = inputPos
	self.rotation = inputRotation
	self.visible = true
	self.in_use = true
	#determine linear_velocity based on x and y components
	self.linear_vel = Vector2(cos(self.rotation),sin(self.rotation))	
	$CollisionShape2D.set_disabled(false)


func _on_Bullet_area_entered(area):
	if(area.is_in_group("enemy")):
		area.hit(self.dmg)
		self.in_use = false
		self.visible = false
		$CollisionShape2D.call_deferred("set_disabled", true)
	
