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




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.battle_started.connect(_on_battle_started)
	SignalBus.battle_text.connect(_on_battle_text)
	SignalBus.pokemon1_HUD.connect(_on_pokemon1_HUD)
	SignalBus.pokemon2_HUD.connect(_on_pokemon2_HUD)
	SignalBus.fight_pressed3.connect(_on_fight_pressed3)
	#SignalBus.damage_calculated.connect(_on_damage_calculated)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_battle_started():
	visible = true
	$Pokemon1HUD.visible = true
	$Pokemon2HUD.visible = true
	$BattleTextBG.visible = false
	$MoveSelection.visible = false

func _on_fight_pressed() -> void:
	SignalBus.fight_pressed2.emit()
	
func _on_fight_pressed3(pmove1, pmove2, pmove3, pmove4) -> void:
	move1 = pmove1
	move2 = pmove2
	move3 = pmove3
	move4 = pmove4
	$"MoveSelection/Move1".disabled = false
	$"MoveSelection/Move2".disabled = false
	$"MoveSelection/Move3".disabled = false
	$"MoveSelection/Move4".disabled = false
	$"MoveSelection/Move1".text = move1.id
	$"MoveSelection/Move2".text = move2.id
	$"MoveSelection/Move3".text = move3.id
	$"MoveSelection/Move4".text = move4.id
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
func _on_move_1_pressed() -> void:
	SignalBus.move1.emit() # pass the logic to pokemon, just cos it's easier to keep track of moves there. 

func _on_move_2_pressed() -> void:
	SignalBus.move2.emit() # attack with move 2

func _on_move_3_pressed() -> void:
	SignalBus.move3.emit() # attack with move 3

func _on_move_4_pressed() -> void:
	SignalBus.move4.emit() # attack with move 4

func _on_move_1_mouse_entered() -> void:
	$MoveSelection/SelectionTypeBox/Type.text = move1.type
	$MoveSelection/SelectionTypeBox/PP.text = "PP: " + str(move1.pp)

func _on_move_2_mouse_entered() -> void:
	$MoveSelection/SelectionTypeBox/Type.text = move2.type
	$MoveSelection/SelectionTypeBox/PP.text = "PP: " + str(move2.pp)

func _on_move_3_mouse_entered() -> void:
	$MoveSelection/SelectionTypeBox/Type.text = move3.type
	$MoveSelection/SelectionTypeBox/PP.text = "PP: " + str(move3.pp)

func _on_move_4_mouse_entered() -> void:
	$MoveSelection/SelectionTypeBox/Type.text = move4.type
	$MoveSelection/SelectionTypeBox/PP.text = "PP: " + str(move4.pp)

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

func _on_pokemon1_HUD():
	pass
	
func _on_pokemon2_HUD():
	pass
#func _on_damage_calculated() -> void:
	#pass
	#update HUD there
			# hide all the other stuff down there, disable buttons and whatnot
			# show the prompttext
			# change prompttext to say what happened
# if caught, send a signal, append to team.
