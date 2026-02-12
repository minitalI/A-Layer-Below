extends Area2D


# decided whether or not to make a seperate scene for each weapon (probably do that) or just show and hide
# sprites plus collision shapes. 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.attack.connect(_on_attack)
	SignalBus.battle_started.connect(_on_battle_started)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_battle_started():
	$Player.show()
	
func _on_attack():
	set_deferred("monitoring", "true")
	# $AnimatedSprite2D.animation = "atttack" this should be what happens eventually but honestly
	# im just gonna hide and show the attack for now.
	$AnimatedSprite2D.show()
	
