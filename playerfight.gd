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
		
	if Input.is_action_pressed("dash"):
		match direction:
			"Down":
				position += Vector2(0, 100 * delta)
				# also change animations
			"Up":
				position += Vector2(0, -100 * delta)
			"Left":
				position += Vector2(-100 * delta, 0)
			"Right":
				position += Vector2(100 * delta, 0)
		
	if Input.is_action_pressed("attack"):
		pass
		# do the attack, display the animation
		# check if the attack hits, if it did, subtract health from the enemy(ies) based on 
		# how much damage the weapon does and modifiers and whatnot. 
		
	if Input.is_action_pressed("run"):
		run = not run
	
	if in_battle == false:
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
	pass
	# deal damage to the player 

func _on_battle_started():
	in_battle = true
