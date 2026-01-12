extends Area2D

var rng = RandomNumberGenerator.new()
var encounter = 0
var run = false
var direction = "Down"
var team = []
var in_battle = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("up"):
		direction = "Up"
		velocity = Vector2(0, -100 * delta)
			
	if Input.is_action_pressed("down"):
		direction = "Down"
		velocity = Vector2(0, 100 * delta)
			
	if Input.is_action_pressed("left"):
		direction = "Left"
		velocity = Vector2(-100 * delta, 0)
			
	if Input.is_action_pressed("right"):
		direction = "Right"
		velocity = Vector2(100 * delta, 0)
		
	if Input.is_action_pressed("run"):
		run = not run
	
	if run == true:
		velocity *= 2
		#$AnimatedSprite2D.animation = "run" + direction
	else:
		pass
		#$AnimatedSprite2D.animation = "walk" + direction
			
	if velocity == Vector2(0, 0):
		pass
		#$AnimatedSprite2D.animation = "idle" + direction

	#$AnimatedSprite2D.play()
	position += velocity

# include pokemon team comp here, at some point send it to the battle scene. 
# also include bag.

func _on_area_entered(area: Area2D) -> void:
	# 6% for most caves and the like, and 2.2% when Surfing.
	# 40% decrease when first entered
	
	#not working dunno why
	#if $CollisionShape2D.disabled == true:
		#$CollisionShape2D.set_deferred("disabled", not $CollisionShape2D.disabled)
		

	print("You entered enemy territory.")
	if rng.randi_range(0, 11) == 1:
		print("A battle has started!")
		SignalBus.battle_started.emit()

func _on_battle_started():
	in_battle = true


# enemies, how are they handled.
# they have a db already.
# there will be a scene for each enemy.
# if there are multiple enemies, simply multiple scenes will be loaded.
# most likely there will ahve to be a check for what enemies are with each enemy, and how many there are
# so it doesnt get overwhelming
# but thats a gameplay change; first, gameplay needs to be possible. 
