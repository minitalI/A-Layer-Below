extends Resource

class_name Enemy

@export var health: int = 0
@export var damage: int = 0
@export var description: String = "Placeholder Description :p"
@export var name: String = "Baby the cat"
@export var path: String = "BabyCat" # this should be used when entering the control phase, to switch to a scene
# that contains the attacks and stuff that this specific enemy has.
@export var encounter_chance: int = 0

func new_enemy(health, damage, desc, name, path, encounter_chance):
	# could have type validation and all that, but honestly uneccesary since its just you making changes.
	var enemy = Enemy.new()
	enemy.health = health
	enemy.damage = damage
	enemy.description = desc
	enemy.name = name
	enemy.path = path
	enemy.encounter_chance = encounter_chance
	return enemy
