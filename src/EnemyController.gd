extends Node

export (PackedScene) var Enemy

var MAX_ENEMIES = 100
var enemies = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Enemies are pulled and re-instantiated from a finite pool to avoid memory issues
func get_free_enemy():
	for enemy in self.enemies:
		if(enemy!=null && !enemy.in_use):
			return enemy
	return null
	
func get_enemy(index):
	return enemies[index]

func spawn_enemy(input_pos,player_owner):	
	var enemy_instance = null	
	if(enemies.size()<MAX_ENEMIES):
		enemy_instance = Enemy.instance()
		enemies.append(enemy_instance)
		add_child(enemy_instance)					
	else:
		enemy_instance = self.get_free_enemy()	
		if(enemy_instance== null):
			return
			
	enemy_instance.spawn(input_pos)
	

		