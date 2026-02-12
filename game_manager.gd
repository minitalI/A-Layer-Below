extends Node

# this is gonna be a honker donker file that will just send singles and the like to 
# other files, like fight logic, to get them to work. 
# fight logic, probably just that for now, and leaving fights. 
# eventually probably also like scene transitions and such as well.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func load_fight_logic():
	var script = preload("res://fightLogic.gd").new()
	add_child(script)
