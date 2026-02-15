extends Node
var rng = RandomNumberGenerator.new()
# okay what do we need here
# first we'll map out the combat;
# movement can be literally copy + pasted from pokemon.

func _ready():
	for i in 100:
		var scene = preload("res://bullet.tscn")
		var bullet = scene.instantiate()
		bullet.speed = 300
		bullet.damage = 0
		bullet.position = Vector2(rng.randi_range(0,1152), rng.randi_range(0, 648))
		bullet.rotation = rng.randi_range(0, 360)
		add_child(bullet)

func _on_button_pressed() -> void:
	# this would then take them to their save files or whatever
	print("pausechamp")
	get_tree().change_scene_to_file("res://area_1.tscn") # this would load their game. for now it just starts at the beginning
