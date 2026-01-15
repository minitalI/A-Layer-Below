extends Node
var rng = RandomNumberGenerator.new()
# okay what do we need here
# first we'll map out the combat;
# movement can be literally copy + pasted from pokemon.
func _ready():
	SignalBus.battle_started.connect(_on_battle_started)
	
func _on_battle_started():
	for i in 100:
		var scene = preload("res://bullet.tscn")
		var bullet = scene.instantiate()
		bullet.speed = 100
		bullet.damage = 5
		bullet.position = Vector2(rng.randi_range(0,2000), rng.randi_range(0, 2000))
		bullet.rotation = rng.randi_range(0, 360)
		
		add_child(bullet)
