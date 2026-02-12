extends AnimatableBody2D

@export var damage: int = 0
@export var speed: int = 0
var test = 0
static var ready_called = false
# for some reason, even though its only being emitted once, _on_player_hit is being called like a thousand times
# in fact, it seems to be cycling through the function several times, and THEN also its calling 
# the function around 8 times. which is NOT correct
# its because ready is being called every time a new bullet is made, which is a certified no bueno moment.
# fixed

func _ready() -> void:
	if ready_called:
		return
	else:
		print("who up rarin they ready to go")
		SignalBus.player_hit.connect(_on_player_hit)
		ready_called = true

# bullet movement is jittery. fix.
func _process(delta: float) -> void:
	var velocity = transform.x * speed * delta
	position += velocity

func _on_player_hit():
				# damage formula should actually be like d * a + m(a * g)^e - (d^e * f - (e + n + s) - e) the exact formula can be modified as needed
			# d is random, a is the weapon attack stat, m is min attack stat, g is weakness, e is eulers number. f is enemy defense, n is the number of hits the move does, s is for the number of enemies it hit
	var damage_dealt = damage / (1 * PlayerInfo.defense)
	PlayerInfo.health -= damage_dealt
