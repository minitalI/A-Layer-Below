extends Area2D


func _ready():
	SignalBus.battle_started.connect(_on_battle_started)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_battle_started():
	hide()
