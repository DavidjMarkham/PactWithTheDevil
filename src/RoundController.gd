extends Node2D

var action_round_in_progress = true
var enemyController
var player
var spawn_timer = 0
var min_spawn_delay = .25
var max_spawn_delay = 1
var max_active = 20
var max_spawn
var num_spawned = 0

# Called when the node enters the scene tree for the first time.
func _ready():	
	self.enemyController = get_node("/root/World/EnemyController")	
	self.player = get_node("/root/World/Player")	
	
	#if(Global.cur_round == 1):
	self.start_round_1()
	
	
func _process(delta):
	if(spawn_timer>0):
		spawn_timer = spawn_timer - delta
	if(Global.cur_round==1):
		self._process_round_1(delta)

func _process_round_1(delta):		
	if(self.num_spawned>=self.max_spawn && self.enemyController.active_enemies == 0):
		# Round Complete
		Global.cur_round = 2
		get_tree().change_scene("res://scenes/DevilDialog.tscn")
		
	if(spawn_timer<=0 && self.enemyController.active_enemies<self.max_active && self.num_spawned<self.max_spawn):		
		# Spawn_enemy			
		self.num_spawned = self.num_spawned + 1
		self.spawn_enemy(1)

func spawn_enemy(level):
	var side_to_spawn = randi() % 4
	var spawn_pos = Vector2(0,0)
	
	if(side_to_spawn==0): 
		# Spawn left
		spawn_pos = Vector2(self.player.position.x-1110,rand_range(self.player.position.y-540,self.player.position.y+540))		
	elif(side_to_spawn==1): 
		# Spawn right
		spawn_pos = Vector2(self.player.position.x+1110,rand_range(self.player.position.y-540,self.player.position.y+540))
	elif(side_to_spawn==2): 
		# Spawn up
		spawn_pos = Vector2(rand_range(self.player.position.x-960,self.player.position.x+960),self.player.position.y-740)
	elif(side_to_spawn==3): 
		# Spawn down
		spawn_pos = Vector2(rand_range(self.player.position.x-960,self.player.position.x+960),self.player.position.y+740)
		
	self.enemyController.spawn_enemy(spawn_pos,1)		
	self.spawn_timer = rand_range(self.min_spawn_delay,self.max_spawn_delay)
	
	
		
func start_round_1():	
	self.action_round_in_progress = true	
	self.max_spawn = 30
	self.num_spawned = 0
	

	
	
	