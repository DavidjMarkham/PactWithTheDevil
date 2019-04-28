extends Node2D

var action_round_in_progress = true
var enemyController
var player
var spawn_timer = 0
var min_spawn_delay = .25
var max_spawn_delay = 1
var max_active = 5
var max_spawn
var num_spawned = 0

# Called when the node enters the scene tree for the first time.
func _ready():	
	self.enemyController = get_node("/root/World/EnemyController")	
	self.player = get_node("/root/World/Player")	
	
	
	self.player.health = self.player.BASE_HEALTH * Global.player_armor_multipler
	
	#if(Global.cur_round == 1):
	self.start_round_1()
	
	
	
func _process(delta):
	if(spawn_timer>0):
		spawn_timer = spawn_timer - delta
	#if(Global.cur_round==1):
	self._process_round_1(delta)

func _process_round_1(delta):		
	if(self.num_spawned>=self.max_spawn && self.enemyController.active_enemies == 0):
		# Round Complete
		Global.cur_round = Global.cur_round + 1
		get_tree().change_scene("res://scenes/EndRound.tscn")
		
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
	self.num_spawned = 0
	
	self.max_active = 40
	self.max_spawn = 250

	if(Global.cur_round == 1):
		self.max_active = 5
		self.max_spawn = 15
	elif(Global.cur_round == 2):
		self.max_active = 6
		self.max_spawn = 18
	elif(Global.cur_round == 3):
		self.max_active = 7
		self.max_spawn = 21
	elif(Global.cur_round == 4):
		self.max_active = 8
		self.max_spawn = 24
	elif(Global.cur_round == 5):
		self.max_active = 9
		self.max_spawn = 30
	elif(Global.cur_round == 6):
		self.max_active = 10
		self.max_spawn = 34
	elif(Global.cur_round == 7):
		self.max_active = 11
		self.max_spawn = 40
	elif(Global.cur_round == 8):
		self.max_active = 12
		self.max_spawn = 48
	elif(Global.cur_round == 9):
		self.max_active = 13
		self.max_spawn = 56
	elif(Global.cur_round == 10):
		self.max_active = 14
		self.max_spawn = 66
	elif(Global.cur_round == 11):
		self.max_active = 15
		self.max_spawn = 72
	elif(Global.cur_round == 12):
		self.max_active = 16
		self.max_spawn = 84
	elif(Global.cur_round == 13):
		self.max_active = 17
		self.max_spawn = 96
	elif(Global.cur_round == 14):
		self.max_active = 18
		self.max_spawn = 109
	elif(Global.cur_round == 15):
		self.max_active = 19
		self.max_spawn = 115
	elif(Global.cur_round == 16):
		self.max_active = 20
		self.max_spawn = 140
	elif(Global.cur_round == 17):
		self.max_active = 24
		self.max_spawn = 170
	elif(Global.cur_round == 18):
		self.max_active = 28
		self.max_spawn = 200
	elif(Global.cur_round == 19):
		self.max_active = 31
		self.max_spawn = 220
	elif(Global.cur_round == 20):
		self.max_active = 35
		self.max_spawn = 230
	
	#self.max_active = 2
	#self.max_spawn = 4 
	self.max_active = self.max_active * Global.enemy_spawn_rate
	self.max_spawn = self.max_spawn * Global.enemy_spawn_rate
	

	
	
	