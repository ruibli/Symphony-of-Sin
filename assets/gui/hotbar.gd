extends Node2D

var hotbar = ["crossbow", "empty", "empty", "empty", "empty", "empty", "empty"]
var tween

func _process(_delta):
	hotbar = Glova.g_hotbar("0")
	$HBoxContainer/slot1.texture = load("res://assets/loot/weapons/"+hotbar[0]+".png")
	$HBoxContainer/slot2.texture = load("res://assets/loot/weapons/"+hotbar[1]+".png")
	$HBoxContainer/slot3.texture = load("res://assets/loot/weapons/"+hotbar[2]+".png")
	$HBoxContainer/slot4.texture = load("res://assets/loot/weapons/"+hotbar[3]+".png")
	$HBoxContainer/slot5.texture = load("res://assets/loot/weapons/"+hotbar[4]+".png")
	$HBoxContainer/slot6.texture = load("res://assets/loot/weapons/"+hotbar[5]+".png")
	$HBoxContainer/slot7.texture = load("res://assets/loot/weapons/"+hotbar[6]+".png")
	
	if Input.is_action_just_pressed("slot1"):
		Glova.g_current(hotbar[0])
		$current.position = $HBoxContainer/slot1.position + Vector2(4,4)
	if Input.is_action_just_pressed("slot2"):
		Glova.g_current(hotbar[1])
		$current.position = $HBoxContainer/slot2.position  + Vector2(4,4)
	if Input.is_action_just_pressed("slot3"):
		Glova.g_current(hotbar[2])
		$current.position = $HBoxContainer/slot3.position + Vector2(4,4)
	if Input.is_action_just_pressed("slot4"):
		Glova.g_current(hotbar[3])
		$current.position = $HBoxContainer/slot4.position + Vector2(4,4)
	if Input.is_action_just_pressed("slot5"):
		Glova.g_current(hotbar[4])
		$current.position = $HBoxContainer/slot5.position + Vector2(4,4)
	if Input.is_action_just_pressed("slot6"):
		Glova.g_current(hotbar[5])
		$current.position = $HBoxContainer/slot6.position + Vector2(4,4)
	if Input.is_action_just_pressed("slot7"):
		Glova.g_current(hotbar[6])
		$current.position = $HBoxContainer/slot7.position + Vector2(4,4)
	
	if Input.is_action_pressed("attack_up") and Glova.g_current("0") == "empty":
		remind()
	if Input.is_action_pressed("attack_down") and Glova.g_current("0") == "empty":
		remind()
	if Input.is_action_pressed("attack_left") and Glova.g_current("0") == "empty":
		remind()
	if Input.is_action_pressed("attack_right") and Glova.g_current("0") == "empty":
		remind()

func remind():
	$remind.modulate = Color(1,1,1,1)
	if tween:
		tween.stop()
	tween = get_tree().create_tween()
	tween.tween_property($remind, "modulate", Color(0, 0, 0, 0), 3)
