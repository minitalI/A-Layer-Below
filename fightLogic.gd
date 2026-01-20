extends Area2D

# ex: var move1 = ["Shadow Claw", "Ghost", "Physical", 70, 100, 24, "High critical hit ratio"]
var team = []
var enemy_team = []
var atk_modifier = 1
var spa_modifier = 1
var def_modifier = 1
var spd_modifier = 1
var spe_modifier = 1
var crt_modifier = 0

func _ready() -> void:
	SignalBus.battle_started.connect(_on_battle_started)
	SignalBus.fight_pressed2.connect(_on_fight_pressed2) # these are all theoretically applicable here. 

func _on_battle_started():
	pass 

func do_damage(enemy_name, skill):  
	var damage = 1
	var enemy = EnemyDB.enemies[enemy_name] # index by chosen enemy
	 # send the damage and what move was done
	if !skill.dtype == "Status": # there will be status, at least in take control and let go
		# potentially take control and let go are builds, and change either combat in bullet hell mode or 
		# combat in turn based mode
		if skill.extra[0] != null:
			do_extra_effects(skill)
			# first check pp, and make the battle text say something about being out of pp
			# if every move is out of pp, make it default to struggle. Somewhere else, also change the name to struggle n stuff.
			
			# get the corresponding stat of the other pokemon
				# def / spd <-- modifiers (iron defense) and abilities should be here
				# atk / spa
				# abilities
			enemy.hp # ehp -- enemy hp
			var edef = enemy.def
			var espd = enemy.spd
			# assume no relevant abilities for now
			
			
			# calculate damage
				# check damage of move
				# check stab
				# check gimmic, ie tera
				# check effectiveness 
				# check miss
				# check abilities
				# send signal to update the text as this is going along
			# name, type, attack type, damage, hit chance, pp, other effects
			var stab = 1
			
			var crit = calculate_crit(crt_modifier)
			
			# it was a crit!
			
			# check effectiveness
			# damage formula should actually be like d * a + m(a * g)^e - (d^e * f - (e + n + s) - e) the exact formula can be modified as needed
			# d is random, a is the weapon attack stat, m is min attack stat, g is weakness, e is eulers number. f is enemy defense, n is the number of hits the move does, s is for the number of enemies it hits
			
			# damage = ((((2 x level) / 5) x power(ofmove) x (atk / def) / 50) + 2) x 
			# targets(.75 if 2, 1 if 1) x pb(parental bond) x weather x glaiverush x critical (1.5) x random(85 - 100 / 100) x stab x type x burn x other 
			var damage1 = 2 * PlayerInfo.level
			var damage2 = skill.damage
			var damage3 = (PlayerInfo.atk * atk_modifier) / edef
			var damage4 = randf_range(85, 100) / 100.0
			var damage5 = ((damage1 / 5) * damage2 * damage3 / 50) + 2
			#damage = int(damage5 * damage4 * stab)
				
			damage = ((((damage1) / 5) * damage2 * (damage3) / 50) + 2) * damage4 * stab 
			damage *= crit
				
				
			if damage <= 0:
				damage = 1
				
			# subtract the other pokemon's health
				# simple health minus damage
				# send signal along with new health to HUD
				# update HUD there
				# hide all the other stuff down there, disable buttons and whatnot
				# show the prompttext
				# change prompttext to say what happened
			
			if enemy.hp - damage <= 0:
				damage = enemy.hp # consider changing, simply so that damage can go really high
			enemy.hp -= damage
			
			if skill.extra[0] == "drain":
				var percent = skill.extra[1] / 100.0
				var heal = damage * percent
				var max_hp = PlayerInfo.health
				if heal < 1:
					heal = 1
				if (not heal + PlayerInfo.health > max_hp):
					PlayerInfo.health += heal

			if crit > 1:
				SignalBus.battle_text.emit({"crit" : true})

			await get_tree().create_timer(2).timeout 
			# change hud by emitting signal with a dict
		else:
			do_extra_effects(skill)
		
		# then, make the scene transition to control mode, send a signal to the HUD and to a scene for each enemy.	
	
# there is going to be more than 4 skills. it would be nice if you could figure out how to send something with the button press.
# for an indeterminate amount of skills, something like
# but dunno how to have the signals do custom stuff like that, buttons just send _on_pressed
#  func _on_skill(skill_number):
	# var skill = PlayerInfo.skills[skill_number]
	# do damage(skill)

func _on_attack():
	var enemy = EnemyDB.enemies[0]["Abstracto"]
	do_damage(enemy, PlayerInfo.attack)
	
func calculate_crit(crt_modifier):
	#var threshold = mon.speed
	# apparently threshold on high crit rates is min(8 * (BaseSpeed / 2), 255) which i dunno what means
	# easieer in later gens actually. 
	# 1 / 24 1 /8
	var threshold = 1 / 24
	var crit = 1
	match crt_modifier:
		1:
			threshold = 8
		2:
			threshold = 4
		3:
			threshold = 2
		4:
			crit = 2
		_:
			threshold = 24
			
	if randi_range(1, threshold) == threshold:
		crit = 2
	else:
		crit = 1
		
	return crit
	
#atx2 sax2 sdx2 spx2 dex2 cr+15 he+50 hl+50
func do_extra_effects(move):
	match move.extra[0]:
		"attack":
			atk_modifier = move.extra[1]
		"special attack":
			spa_modifier = move.extra[1]
		"defense":
			def_modifier = move.extra[1]
		"special defense":
			spd_modifier = move.extra[1]
		"speed":
			spe_modifier = move.extra[1]
		"crit":
			crt_modifier = move.extra[1]
		"heal":
			var heal = PlayerInfo.health * (move.extra[1] / 100)
			var max_hp = PlayerInfo.health
			
			if (heal < 1):
				heal = 1
			
			if (not heal + PlayerInfo.health > max_hp):
				PlayerInfo.health += heal

func _on_fight_pressed2(): # why?
	SignalBus.fight_pressed3.emit(team[0].move1, team[0].move2, team[0].move3, team[0].move4)
	
