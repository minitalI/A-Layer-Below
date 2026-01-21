extends Node
var rng = RandomNumberGenerator.new()
# okay what do we need here
# first we'll map out the combat;
# movement can be literally copy + pasted from pokemon.
func _ready():
	SignalBus.battle_started.connect(_on_battle_started)
	SignalBus.start_game.connect(_on_game_started)
	
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
	SignalBus.start_game.emit() # this would load their game. for now it just starts at the beginning
	# everything else is going where they need to go it is just specifically this signal for some reason.
	# my guess is that its probably to do with the order these things are loaded or something.
	print("pausechamp")
	
func _on_game_started():
	# why is it going here but not there. i LITERALLY copy pasted the connection.
	print("please??")
