extends Node
# this file is to hold the name of a bunch of enemies, as well as their stats,
# and a path to their attakcs in the trust phase,
# for use in battle

# possibly there should be an autoload with the enemies that appear in each area
# or maybe that can just go here, it wouldn't be a lot of added info.
# but that needs to be somewhere, so when an encounter happens, it can be randomly chosen.
#  health, damage, desc, name, path 
var enemies : Array = [
	{"temp" : Enemy.new().new_enemy(100, 5, "desc", "Baby", "BabyCat", "100")}
]
