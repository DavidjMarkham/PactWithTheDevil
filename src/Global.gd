extends Node
# Singleton used for sharing variables across multiple scenes

var cur_round = 1
var accepted_bet = false

# Rewards
var player_speed_multipler = 1
var player_fire_rate_multipler = 1
var player_armor_multipler = 1
var player_has_spread_shot = false
var player_has_super_spread_shot = false

# Handicaps
var enemy_armor_multiplier = 1
var enemy_move_speed_multiplier = 1
var enemy_fire_rate_multiplier = 1
var enemy_spawn_rate = 1