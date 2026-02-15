extends Area2D

# im putting this here so i never forget
# it seems the cat entirely destroyed my fight scene and fight logic scene
# very glad i started to use github
# use github more
# like an hour of work was lost

# ex: var move1 = ["Shadow Claw", "Ghost", "Physical", 70, 100, 24, "High critical hit ratio"]
var team = []
var enemy_team = []
var atk_modifier = 1
var spa_modifier = 1
var def_modifier = 1
var spd_modifier = 1
var spe_modifier = 1
var crt_modifier = 0
var enemy = null
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	SignalBus.battle_started.connect(on_battle_started)
	SignalBus.skill.connect(_on_skill)
	
func on_battle_started(e):
	enemy = e

func do_damage(skill):  
	skill = PlayerInfo.skills[skill]
	if rng.randi_range(0, 100) <= skill.accuracy:
		
		
		#if !skill.dtype == "Status": # there will be status, at least in take control and let go
			# potentially take control and let go are builds, and change either combat in bullet hell mode or 
			# combat in turn based mode
			#if skill.extra[0] != null:
				#do_extra_effects(skill)
				
				# get the corresponding stat of the other pokemon
					# def / spd <-- modifiers (iron defense) and abilities should be here
					# atk / spa
					# abilities
		var edef = enemy.defense

		# calculate damage
			# check damage of move
			# check gimmic
			# check effectiveness 
			# check miss
			# check abilities
			# send signal to update the text as this is going along
		
		var crit = calculate_crit(crt_modifier)
		
		# it was a crit!
		
		# check effectiveness
		# damage formula should actually be like d * a + m(a * g)^e - (d^e * f - (e + n + s) - e) the exact formula can be modified as needed
		# d is random, a is the weapon attack stat, m is min attack stat, g is weakness, e is eulers number. f is enemy defense, n is the number of hits the move does, s is for the number of enemies it hits
		
		# damage4 * skill.damage * (PlayerInfo.damage * (skill.damage * (PlayerInfo.level / 5)))^e - (damage4^e * edef - (e + skill.num_hits + (figure out how many enemies hit)) - e)
		# damage = ((((2 x level) / 5) x power(ofmove) x (atk / def) / 50) + 2) x 
		# targets(.75 if 2, 1 if 1) x pb(parental bond) x weather x glaiverush x critical (1.5) x random(85 - 100 / 100) x stab x type x burn x other 
		var damage1 = 2 * PlayerInfo.level
		var damage2 = skill.damage
		var damage3 = (PlayerInfo.attack * atk_modifier + 0.0) / edef
		var damage4 = randf_range(85, 100) / 100.0
		var damage5 = ((((damage1 / 5.0) * damage2 * damage3)) / 5) * (skill.damage + 2 + PlayerInfo.attack)
		#damage = int(damage5 * damage4 * stab)
		# ((2 / 5) * 1000 * 1) / 5) + 2
		var damage = damage5 * damage4 
		damage *= crit
		damage = round(damage)
			
		if damage <= 0:
			damage = 1
			
		# subtract the other pokemon's health
			# simple health minus damage
			# send signal along with new health to HUD
			# update HUD there
			# hide all the other stuff down there, disable buttons and whatnot
			# show the prompttext
			# change prompttext to say what happened

		enemy.health -= damage # skill name enemy name damage 
		SignalBus.send_battle_text.emit({"skill" : true, "skill name" : skill["name"], "enemy name" : enemy["name"], "damage" : damage})
		if skill.extra == "drain":
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
		# also, if enemy health <= 0, queue.free()

		do_extra_effects(skill)
		
		# then, make the scene transition to control mode, send a signal to the HUD and to a scene for each enemy.	
	else:
		SignalBus.send_battle_text.emit({"miss" : true, "skill name" : skill["name"]})
# there is going to be more than 4 skills. it would be nice if you could figure out how to send something with the button press.
# for an indeterminate amount of skills, something like
# but dunno how to have the signals do custom stuff like that, buttons just send _on_pressed
#  func _on_skill(skill_number):
	# var skill = PlayerInfo.skills[skill_number]
	# do damage(skill)
	
func _on_skill(skill):
	# the name of the enemy will have to be gotten at some point.
	# honestly im not sure if it'd be better to just make a global enemy though.
	# probably it would, but also maybe instead of passing the 
	do_damage(skill)
	
func _on_attack():
	do_damage(PlayerInfo.attack)
	
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
func do_extra_effects(skill):
	match skill.extra:
		"tired":
			pass # enemy bullets move slower
		"skillCheck":
			pass # if skill missed, does damage to Min
		"attack":
			atk_modifier = skill.extra			
		"special attack":
			spa_modifier = skill.extra
		"defense":
			def_modifier = skill.extra
		"special defense":
			spd_modifier = skill.extra
		"speed":
			spe_modifier = skill.extra
		"crit":
			crt_modifier = skill.extra
		"heal":
			var heal = PlayerInfo.health * (skill.extra / 100)
			var max_hp = PlayerInfo.health
			
			if (heal < 1):
				heal = 1
			
			if (not heal + PlayerInfo.health > max_hp):
				PlayerInfo.health += heal

func _on_fight_pressed2(): # why? 
	SignalBus.fight_pressed3.emit(team[0].move1, team[0].move2, team[0].move3, team[0].move4)
	# it was to get the moves and send it back to the hud.................
