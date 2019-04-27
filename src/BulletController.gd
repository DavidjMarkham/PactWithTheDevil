extends Node

export (PackedScene) var Bullet

var MAX_BULLETS = 1000
var bullets = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Enemies are pulled and re-instantited from a finite pool to avoid memory issues
func get_free_enemy():
	for bullet in self.bullets:
		if(bullet!=null && !bullet.in_use):
			return bullet
	return null
	
func get_enemy(index):
	return bullets[index]

func fire_bullet(input_pos,player_owner,input_rotation):	
	var bullet_instance = null	
	if(bullets.size()<MAX_BULLETS):
		bullet_instance = Bullet.instance()
		bullets.append(bullet_instance)
		add_child(bullet_instance)					
	else:
		bullet_instance = self.get_free_enemy()	
		if(bullet_instance== null):
			return
			
	bullet_instance.spawn(input_pos,input_rotation)
	

		