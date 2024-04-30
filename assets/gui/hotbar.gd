extends Node2D

var hotbar = ["crossbow", "empty", "empty", "empty", "empty", "empty", "empty"]
var slot = 1
var remind_tween
var cooldown_tween
var swap = [0,0]
var can_swap = true

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
		slot = 1
		$current.position = $HBoxContainer/slot1.position + Vector2(4,4)
	if Input.is_action_just_pressed("slot2"):
		Glova.g_current(hotbar[1])
		slot = 2
		$current.position = $HBoxContainer/slot2.position  + Vector2(4,4)
	if Input.is_action_just_pressed("slot3"):
		Glova.g_current(hotbar[2])
		slot = 3
		$current.position = $HBoxContainer/slot3.position + Vector2(4,4)
	if Input.is_action_just_pressed("slot4"):
		Glova.g_current(hotbar[3])
		slot = 4
		$current.position = $HBoxContainer/slot4.position + Vector2(4,4)
	if Input.is_action_just_pressed("slot5"):
		Glova.g_current(hotbar[4])
		slot = 5
		$current.position = $HBoxContainer/slot5.position + Vector2(4,4)
	if Input.is_action_just_pressed("slot6"):
		Glova.g_current(hotbar[5])
		slot = 6
		$current.position = $HBoxContainer/slot6.position + Vector2(4,4)
	if Input.is_action_just_pressed("slot7"):
		Glova.g_current(hotbar[6])
		slot = 7
		$current.position = $HBoxContainer/slot7.position + Vector2(4,4)
	
	if get_tree().paused == false:
		$swap.position = $HBoxContainer/slot1.position + Vector2(-24,4)
		$controls.modulate = Color(0,0,0,0)
		
		if Input.is_action_pressed("attack_up") and Glova.g_current("0") == "empty":
			remind()
		if Input.is_action_pressed("attack_down") and Glova.g_current("0") == "empty":
			remind()
		if Input.is_action_pressed("attack_left") and Glova.g_current("0") == "empty":
			remind()
		if Input.is_action_pressed("attack_right") and Glova.g_current("0") == "empty":
			remind()
			
	if Glova.g_cooldown(-1) != 0:
		if slot == 1:
			$HBoxContainer/slot1/slot1_cd.value = 1
			cooldown_tween = get_tree().create_tween()
			cooldown_tween.tween_property($HBoxContainer/slot1/slot1_cd, "value", 0, Glova.g_cooldown(-1))
			Glova.g_cooldown(0)
		elif slot == 2:
			$HBoxContainer/slot2/slot2_cd.value = 2
			cooldown_tween = get_tree().create_tween()
			cooldown_tween.tween_property($HBoxContainer/slot2/slot2_cd, "value", 0, Glova.g_cooldown(-1))
			Glova.g_cooldown(0)
		elif slot == 3:
			$HBoxContainer/slot3/slot3_cd.value = 1
			cooldown_tween = get_tree().create_tween()
			cooldown_tween.tween_property($HBoxContainer/slot3/slot3_cd, "value", 0, Glova.g_cooldown(-1))
			Glova.g_cooldown(0)
		elif slot == 4:
			$HBoxContainer/slot4/slot4_cd.value = 1
			cooldown_tween = get_tree().create_tween()
			cooldown_tween.tween_property($HBoxContainer/slot4/slot4_cd, "value", 0, Glova.g_cooldown(-1))
			Glova.g_cooldown(0)
		elif slot == 5:
			$HBoxContainer/slot5/slot5_cd.value = 1
			cooldown_tween = get_tree().create_tween()
			cooldown_tween.tween_property($HBoxContainer/slot5/slot5_cd, "value", 0, Glova.g_cooldown(-1))
			Glova.g_cooldown(0)
		elif slot == 6:
			$HBoxContainer/slot6/slot6_cd.value = 1
			cooldown_tween = get_tree().create_tween()
			cooldown_tween.tween_property($HBoxContainer/slot6/slot6_cd, "value", 0, Glova.g_cooldown(-1))
			Glova.g_cooldown(0)
		elif slot == 7:
			$HBoxContainer/slot7/slot7_cd.value = 1
			cooldown_tween = get_tree().create_tween()
			cooldown_tween.tween_property($HBoxContainer/slot7/slot7_cd, "value", 0, Glova.g_cooldown(-1))
			Glova.g_cooldown(0)
			
	if get_tree().paused == true:
		$remind.modulate = Color(0,0,0,0)
		$controls.modulate = Color(1,1,1,1)
		
		if Input.is_action_pressed("swap") and can_swap:
			if slot == 1 and $HBoxContainer/slot1/slot1_cd.value == 0:
				if swap[0] == 0:
					swap[0] = slot
					$swap.position = $HBoxContainer/slot1.position + Vector2(4,4)
				elif swap[0] != slot:
					swap[1] = slot
			elif slot == 2 and $HBoxContainer/slot2/slot2_cd.value == 0:
				if swap[0] == 0:
					swap[0] = slot
					$swap.position = $HBoxContainer/slot2.position + Vector2(4,4)
				elif swap[0] != slot:
					swap[1] = slot
			elif slot == 3 and $HBoxContainer/slot3/slot3_cd.value == 0:
				if swap[0] == 0:
					swap[0] = slot
					$swap.position = $HBoxContainer/slot3.position + Vector2(4,4)
				elif swap[0] != slot:
					swap[1] = slot
			elif slot == 4 and $HBoxContainer/slot4/slot4_cd.value == 0:
				if swap[0] == 0:
					swap[0] = slot
					$swap.position = $HBoxContainer/slot4.position + Vector2(4,4)
				elif swap[0] != slot:
					swap[1] = slot
			elif slot == 5 and $HBoxContainer/slot5/slot5_cd.value == 0:
				if swap[0] == 0:
					swap[0] = slot
					$swap.position = $HBoxContainer/slot5.position + Vector2(4,4)
				elif swap[0] != slot:
					swap[1] = slot
			elif slot == 6 and $HBoxContainer/slot6/slot6_cd.value == 0:
				if swap[0] == 0:
					swap[0] = slot
					$swap.position = $HBoxContainer/slot6.position + Vector2(4,4)
				elif swap[0] != slot:
					swap[1] = slot
			elif slot == 7 and $HBoxContainer/slot7/slot7_cd.value == 0:
				if swap[0] == 0:
					swap[0] = slot
					$swap.position = $HBoxContainer/slot7.position + Vector2(4,4)
				elif swap[0] != slot:
					swap[1] = slot
		
		if swap[0] != 0:
			if swap[1] != 0:
				var save = hotbar[swap[1]-1]
				$swap.position = $HBoxContainer/slot1.position + Vector2(-24,4)
				hotbar[swap[1]-1] = hotbar[swap[0]-1]
				hotbar[swap[0]-1] = save
				swap = [0,0]
				can_swap = false
				$swap_cd.start()
		else:
			$swap.position = $HBoxContainer/slot1.position + Vector2(-24,4)

func remind():
	$remind.modulate = Color(1,1,1,1)
	if remind_tween:
		remind_tween.stop()
	remind_tween = get_tree().create_tween()
	remind_tween.tween_property($remind, "modulate", Color(0, 0, 0, 0), 3)

func _on_swap_cd_timeout():
	can_swap = true
