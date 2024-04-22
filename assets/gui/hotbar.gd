extends Node2D

var hotbar = ["crossbow", "empty", "empty", "empty", "empty", "empty", "empty", "empty"]

func _process(_delta):
	hotbar = Glova.g_hotbar("0")
	$HBoxContainer/slot1.texture = load("res://assets/loot/weapons/"+hotbar[0]+".png")
	$HBoxContainer/slot2.texture = load("res://assets/loot/weapons/"+hotbar[1]+".png")
	$HBoxContainer/slot3.texture = load("res://assets/loot/weapons/"+hotbar[2]+".png")
	$HBoxContainer/slot4.texture = load("res://assets/loot/weapons/"+hotbar[3]+".png")
	$HBoxContainer/slot5.texture = load("res://assets/loot/weapons/"+hotbar[4]+".png")
	$HBoxContainer/slot6.texture = load("res://assets/loot/weapons/"+hotbar[5]+".png")
	$HBoxContainer/slot7.texture = load("res://assets/loot/weapons/"+hotbar[6]+".png")
	$HBoxContainer/slot8.texture = load("res://assets/loot/weapons/"+hotbar[7]+".png")
	
	if Input.is_action_just_pressed("slot1"):
		Glova.g_current(hotbar[0])
		$current.position = $HBoxContainer/slot1.position
	if Input.is_action_just_pressed("slot2"):
		Glova.g_current(hotbar[1])
		$current.position = $HBoxContainer/slot2.position
	if Input.is_action_just_pressed("slot3"):
		Glova.g_current(hotbar[2])
		$current.position = $HBoxContainer/slot3.position
	if Input.is_action_just_pressed("slot4"):
		Glova.g_current(hotbar[3])
		$current.position = $HBoxContainer/slot4.position
	if Input.is_action_just_pressed("slot5"):
		Glova.g_current(hotbar[4])
		$current.position = $HBoxContainer/slot5.position
	if Input.is_action_just_pressed("slot6"):
		Glova.g_current(hotbar[5])
		$current.position = $HBoxContainer/slot6.position
	if Input.is_action_just_pressed("slot7"):
		Glova.g_current(hotbar[6])
		$current.position = $HBoxContainer/slot7.position
	if Input.is_action_just_pressed("slot8"):
		Glova.g_current(hotbar[7])
		$current.position = $HBoxContainer/slot8.position
