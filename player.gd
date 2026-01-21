extends Area2D

var rng = RandomNumberGenerator.new()
var run: bool = false
var direction: String = "Down"



func _ready() -> void:
	pass
	# probably going to want to connect a signal for when the phase changes from trust to control, to spawn.

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("up"):
		direction = "Up"
		velocity += Vector2(0, -PlayerInfo.speed * delta)
			
	if Input.is_action_pressed("down"):
		direction = "Down"
		velocity += Vector2(0, PlayerInfo.speed * delta)
			
	if Input.is_action_pressed("left"):
		direction = "Left"
		velocity += Vector2(-PlayerInfo.speed * delta, 0)
			
	if Input.is_action_pressed("right"):
		direction = "Right"
		velocity += Vector2(PlayerInfo.speed * delta, 0)
		
	if Input.is_action_pressed("run"):
		run = not run
	
	# because player moves faster if going diagonally. 
	# .4 because thats the hypontenouse
	if velocity.x != 0 and velocity.y != 0:
		velocity -= Vector2((velocity.x * .4), (velocity.y * .4))
		
	# might want animations for non cardinal directions, dunno. 
	# definitely will want to hard code what animation plays when going in a direction.
	
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

func _on_area_entered(area: Area2D) -> void:
	# 6% for mo8st caves and the like, and 2.2% when Surfing.
	# 40% decrease when first entered
	
	#not working dunno why
	#if $CollisionShape2D.disabled == true:
		#$CollisionShape2D.set_deferred("disabled", not $CollisionShape2D.disabled)
		

	print("You entered enemy territory.")
	if rng.randi_range(0, 11) == 1:
		print("A battle has started!")
		SignalBus.battle_started.emit()


# enemies, how are they handled.
# they have a db already.
# there will be a scene for each enemy.
# if there are multiple enemies, simply multiple scenes will be loaded.
# most likely there will ahve to be a check for what enemies are with each enemy, and how many there are
# so it doesnt get overwhelming
# but thats a gameplay change; first, gameplay needs to be possible. 
# so for now just get enemies working.
# that said, there should be an amount of randomness in some attacks, for variety and so that it even kind
# of works with multiple enemies.
