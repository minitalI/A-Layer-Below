extends CanvasLayer

var move1
var move2
var move3
var move4
# ex turn
# Hysloth withdrew Houndoom!
# Hysloth sent out Venusaur!

# Urshifu used Close Combat!
# It's not very effective...
# A critical hit!
# (The opposing Venusaur lost 54% of its health!)
# Urshifu's Defense fell!
# Urshifu's Sp. Def fell!

# The opposing Venusaur restored a little HP using its Leftovers!


# this is horrifying.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.battle_started.connect(_on_battle_started)
	#SignalBus.damage_calculated.connect(_on_damage_calculated)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_battle_started():
	$BattleTextBG.visible = false
	$MoveSelection.visible = false


func _on_fight_pressed() -> void:
	var i = 0
	for skill in PlayerInfo.skills:
		# ig then make a box for each skill with the name [skill] so it can be done iterably.
		# wait
		# how do
		# could do that, but also, if individual skills have different boxes. 
		# aha
		# make a list of buttons, the buttons are not there before, instantiate as you go
		var btn = Button.new() # or create a button scene instead
		btn.text = skill
		btn.pressed.connect(_on_skill.bind(skill))
		btn.mouse_entered.connect(_on_skill_mouse_entered.bind(skill))
		btn.size = Vector2(160, 80) # it would be fun to change the size based on the size of the text
		# that way differently long names could be differently big.
		# also, something needs to be in place so that if it goes far enough, it just makes another layer
		# that for now could be if i > 4, but when 4 isn't an indicator of ow far it goes,
		# it'll have to be something more complex, like if 50 + i > xyz
		# either that or have the skills scroll
		
		btn.position = Vector2(50 + i, 520)
		i += 200 # ideally, the size of the last one + 20 or so
		add_child(btn)
		
		# probably should make all buttons like this, custom signals and all.
		
	$MoveSelection.visible = true
	$PromptTextBG.visible = false
	
func _on_bag_pressed() -> void:
	pass # Replace with function body.

func _on_run_pressed() -> void:
	# if not player.speed > wild.speed:
	# F = (((A * 128)/B) + 30 * C) mod 256
	pass

func _on_pokemon_pressed() -> void:
	pass # show current team

# seems like you could probably loop this. for move in moves: move x connect move x pressed or hovered
# func move x pressed do move x effect, func move x hovered display move x information
func _on_skill(skill):
	SignalBus.skill.emit(skill)
	
func _on_skill_mouse_entered(skill):
	print("wowow you did it yay you hovered over the box with your mouse")
	#$MoveSelection/SelectionTypeBox/Type.text = move1.type
	#$MoveSelection/SelectionTypeBox/PP.text = "PP: " + str(move1.pp)

# find out how to make the stuff not neccessary
# overload the function, probably
func _on_battle_text(packet: Dictionary):
	if packet.has("move"):
		$PromptTextBG.hide()
		$MoveSelection.hide()
		$BattleTextBG/BattleText.text = str(packet["pk1 name"]) + " used " + str(packet["move name"]) + "!"
		$BattleTextBG.show()
		# or OS.delay_msec(<value>)
			
	if packet.has("damage dealt"):
		# in this context pk 2 is enemy mon
		$BattleTextBG/BattleText.text = "The opposing " + str(packet["pk2 name"]) + " lost " + str(int(packet["damage"])) + " health!" # also include percent 
		# need diff pk_name, this is for your pk 
		$Pokemon1HUD/HPNumbers.text = str(int(packet["health"])) + " / " + str(packet["max health"])
		await get_tree().create_timer(2).timeout 
		$PromptTextBG.show()
		$BattleTextBG.hide()
			
	if packet.has("effective"):
		$BattleTextBG/BattleText.text = "It's super effective!"
			
	if packet.has("not effective"):
		$BattleTextBG/BattleText.text = "It's not very effective..."
			
	if packet.has("switch"):
		$PromptTextBG.hide()
		$MoveSelection.hide()
		$BattleTextBG.show()
		$BattleTextBG/BattleText.text = str(packet["player1 name"]) + " withdrew " + str(packet["pk1 name"]) + "!"
		# need other player name and your player name, plus two pokemon names
		await get_tree().create_timer(2).timeout 
		$BattleTextBG/BattleText.text = str(packet["player1 name"]) + " sent out " + str(packet["pk2 name"]) + "!"
			
	if packet.has("replace"):
		$PromptTextBG.hide()
		$MoveSelection.hide()
		$BattleTextBG.show()
		$BattleTextBG/BattleText.text = str(packet["pk_name"]) + " replaced " + str(packet["pk_name"]) + "!"
		# needs the two pokemon names
			
	if packet.has("crit"):
		$BattleTextBG/BattleText.text = "A critical hit!"
			
	await get_tree().create_timer(2).timeout 

#func _on_damage_calculated() -> void:
	#pass
	#update HUD there
			# hide all the other stuff down there, disable buttons and whatnot
			# show the prompttext
			# change prompttext to say what happened
# if caught, send a signal, append to team.

# autoloads:
   #Are always loaded, no matter which scene is currently running.

   #Can store global variables such as player information.

   #Can handle switching scenes and between-scene transitions.

   #Act like a singleton, since GDScript does not support global variables by design.

# this does not seem like fight logic fits the autoload paradigm. 
# that said
