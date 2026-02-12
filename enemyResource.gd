extends Resource

class_name Enemy

@export var health: int = 0
@export var damage: int = 0
@export var description: String = "Placeholder Description :p"
@export var name: String = "Baby the cat"
@export var path: String = "BabyCat" # this should be used when entering the control phase, to switch to a scene
# that contains the attacks and stuff that this specific enemy has.
@export var encounter: int = 0
@export var defense: int = 0

var current_enemies : Dictionary = {
	
}

var all_enemies : Dictionary = {
	"temp" : {"health" : 100, "damage" : 5, "description" : "desc", "path" : "BabyCat", "encounter" : "100"},
	"Abstracto" : {"health" : 80, "damage" : 10, "defense" : 20, "description" : "A remanant of a truth in the process of passing on.", "path" : "res://abstracto.tscn", "encounter" : 25},
	"Abstractoid" : {"health" : 20, "damage" : 10, "defense" : 5, "description" : "A remnant of a truth passed on", "path" : "res://abstractoid.tscn", "encounter" : 0},
	"The King" : {"health" : 100, "damage": 0,  "defense" : 50,"description" : "A humble elitist. Kings tend to lounge while their knights and peons do the work. Cripplingly lonely and compensate for their low self esteem by hoarding relationships like wealth.", "path" : "res://theking.tscn", "encounter" : 25},
	"The Queen" : {"health" : 60, "damage" : 50, "defense" : 30, "description" : "A true ruler. Queen's are nimble fighters who are unafraid to go down in a fight. They would sooner die then give up their secrets.", "path" : "res://thequeen.tscn", "encounter" : 20},
	"Kingling" : {"health" : 30, "damage" : 10, "defense" : 10, "description" : "One of a king's many followers. They would die for their king rather than develop their own sense of personhood.", "path" : "res://kingling.tscn", "encounter" : 0},
	"Peasant" : {"health" : 50, "damage" : 30, "defense" : 20, "description" : "A ruler waiting to be born. These peasants haven't yet resolved on a path to take throughout their lives and are largely aimless.", "path" : "res://peasant.tscn", "encounter" : 25}
}

	# this is a whole area, then. It ought to be "the court", if we stick with this
	# also, peasant can become jester.
	# truthfully, this seems kinda boring. you can do better. Because this is just a normal court
	# also does not feel like a area 1 type area
	# the thing is supposed to be that it's like a school, though. Popular kid, confident person covering their fears,
	# follower of the popular kid, and just the average joe who doesn't wanna make a splash and just wants to get through.
	# still, theres also the class clown and creative, at least.
	# there's also even here the ghosts of truths that have been told
	# also potential abstracto lore, it changes based on the area.
	# cos duh, every passed on truth does not look the same. 
	# also huge abstracto note, that guy is probably gonna become just a ghostly, or like
	# in some way obscured version of a normal enemy. that obscuring might be abstraction
	# but probably not.
# 20, 5, 50, 30, 10, 20
var area_enemies : Dictionary = { 
	1 : {
		"Abstracto" : {"health" : 80, "damage" : 10,  "defense" : 20,"description" : "A remanant of a truth in the process of passing on.", "path" : "res://abstracto.tscn", "encounter" : 30},
		"Abstractoid" : {"health" : 20, "damage" : 10,  "defense" : 5,"description" : "A remnant of a truth passed on", "path" : "res://abstractoid.tscn", "encounter" : 0},
		"The King" : {"health" : 100, "damage": 0,  "defense" : 50,"description" : "A humble elitist. Kings tend to lounge while their knights and peons do the work. Cripplingly lonely and compensate for their low self esteem by hoarding relationships like wealth.", "path" : "res://theking.tscn", "encounter" : 25},
		"The Queen" : {"health" : 60, "damage" : 50,  "defense" : 30,"description" : "A true ruler. Queen's are nimble fighters who are unafraid to go down in a fight. They would sooner die then give up their secrets.", "path" : "res://thequeen.tscn", "encounter" : 20},
		"Kingling" : {"health" : 30, "damage" : 10,  "defense" : 10,"description" : "One of a king's many followers. They would die for their king rather than develop their own sense of personhood.", "path" : "res://kingling.tscn", "encounter" : 0},
		"Peasant" : {"health" : 50, "damage" : 30,  "defense" : 20,"description" : "A ruler waiting to be born. These peasants haven't yet resolved on a path to take throughout their lives and are largely aimless.", "path" : "res://peasant.tscn", "encounter" : 25}
	},
	2 : {
		"temp" : {"health" : 100, "damage" : 5, "description" : "desc", "path" : "BabyCat", "encounter" : 100},
		"Abstracto" : {"health" : 80, "damage" : 10, "description" : "A remanant of a truth in the process of passing on.", "path" : "res://abstracto.tscn", "encounter" : 25},
		"Abstractoid" : {"health" : 20, "damage" : 10, "description" : "A remnant of a truth passed on", "path" : "res://abstractoid.tscn", "encounter" : 0}
	}
}

func new_enemy(name):
	# could have type validation and all that, but honestly uneccesary since its just you making changes.
	var e = Enemy.new()
	var enemy = all_enemies[name]
	e.health = enemy["health"]
	e.damage = enemy["damage"]
	e.defense = enemy["defense"]
	e.description = enemy["description"]
	e.path = enemy["path"]
	e.encounter = enemy["encounter"]
	return e

func set_enemies(area):
	# for some reason current_enemies keeps going back to nothing, i think it 
	# has to do with the scene change. area is probably something to store in some 
	# kind of autoload, thoughm 
	current_enemies.clear()
	
	for enemy in area_enemies[area]:
		current_enemies[enemy] = area_enemies[area][enemy]

func get_enemy():
	var enemy = null
	
	set_enemies(1)
	var random_enemies = []
	for e in current_enemies: 
		for i in range(current_enemies[e]["encounter"]):
			random_enemies.append(e)
			
	enemy = random_enemies.pick_random()
	enemy = new_enemy(enemy)
	return enemy
