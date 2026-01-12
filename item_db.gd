extends Node
# possibly temporary, since it seems like this could potentially be a horrible practice,

# could make general classes, like heavy weapon, light weapon, ranged weapon. depends on how many weapons to include
# that said it doesnt seem hard to make a buncha weapons.
# also there should probably be a weapon class here, that has the stats and specials of each weapon
# meaning this would have to be an array of dicts.
@export var weapons: Array = ["spear", "sword", "knife", "hammer", "axe", "bow", "gun", "shield"]

# also include any other potential items, like healing, throwing, quest items, repels. 
# its still funny to have an item called a repel that repels literal people.

func new_item():
	pass 
	# this should make a new item
	# also im actually not super sure thsi is a good way to handle this.
	# because all the items are very different, so theres not really many global variables.
	# itd be nice to make a class and then several inheritances
	# and the class is just something that can be used
	# but im not sure if godot can do that
	# so probably you should just make healing items, damaging items, all that jazz in different files
	# seems inefficient but it works.
	# weapons definitely need to be in a different file though.
