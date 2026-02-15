extends Node

@export var speed: int = 100
@export var invincibility_window: float = .08
@export var health: int = 50
@export var attack: int = 20
@export var defense: int = 10
@export var level: int = 1
@export var username: String = "Min"
@export var experience: int = 0

@export var skills: Dictionary = {
	"Backflip" : {"name" : "Backflip", "damage" : 39, "accuracy" : 80, "extra" : "skillCheck", "desc" : "Min does a sick backflip and kicks the opponent in the face. If missed, Min gets damaged."}, 
	"Bite" : {"name" : "Bite", "damage" : 20, "accuracy" : 100, "extra" : "None", "desc" : "The ghost rushes forward and bites the opponent in the shin."},
	"Shotgun" : {"name" : "Shotgun", "damage" : 1000, "accuracy" : 5, "extra" : "None", "desc" : "The ghost brings Min a one-use shotgun, but Min can't aim very well."},
	"Slothful Gaze" : {"name" : "Slothful Gaze", "damage" : 0, "accuracy" : 100, "extra" : "tired", "desc" : "The ghost fixes the opponent with a sleepy gaze."}
}
# ugh, there should probably be a class for skills as well.
var weapon = "whatever man"

# also needs to store the skills the player can learn
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
