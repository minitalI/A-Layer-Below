extends Resource

class_name Enemy

@export var health: int = 0
@export var damage: int = 0
@export var description: String = "Placeholder Description :p"
@export var name: String = "Baby the cat"
@export var path: String = "BabyCat" # this should be used when entering the control phase, to switch to a scene
# that contains the attacks and stuff that this specific enemy has.

func new_enemy(health, damage, desc, name, path):
	var enemy = Enemy.new()
	enemy.health = health
	enemy.damage = damage
	enemy.description = desc
	enemy.name = name
	enemy.path = path
	return enemy
