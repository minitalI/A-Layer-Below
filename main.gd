extends Node
var rng = RandomNumberGenerator.new()
# okay what do we need here
# first we'll map out the combat;
# movement can be literally copy + pasted from pokemon.

func _ready():
	SignalBus.battle_started.connect(_on_battle_started)
	
func _on_battle_started():
	# bullets are using quantum mechanics. fix. 
	
	for i in 100:
		var scene = preload("res://bullet.tscn")
		var bullet = scene.instantiate()
		bullet.speed = 300
		bullet.damage = 5
		bullet.position = Vector2(rng.randi_range(0,2000), rng.randi_range(0, 2000))
		bullet.rotation = rng.randi_range(0, 360)
		
		add_child(bullet)


func _on_button_pressed() -> void:
	# this would then take them to their save files or whatever
	print("pausechamp")
	get_tree().change_scene_to_file("res://area_1.tscn") # this would load their game. for now it just starts at the beginning
	# use scene change or whatever.

	
	# its not that its not sending
	# its not that the connection is wrong
	# what is it then....
	# well its obviously emitting.
	# also other files can emit to this one. 
	# other signals work with this one.
	# so its probably that the other files aren't recieving the signals. 
	# because other files also fail to send the signals, but to this one. 
	
	# everything else is going where they need to go it is just specifically this signal for some reason.
	# my guess is that its probably to do with the order these things are loaded or something.
	# no it happens after everything is loaded, cos i need to press button. 
