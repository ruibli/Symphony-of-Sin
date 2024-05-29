extends Control

@export var pedestal_scene: PackedScene

var nam = " "
var items = ["coin","potion","item","weapon"]
var items_index = 0
var item_pool
var item_index = 0
var weapon_pool
var weapon_index = 0

func _ready():
	hide()

func _process(_delta):
	item_pool = Glova.i_pool_full.duplicate()
	item_pool.append("painting")
	weapon_pool = Glova.w_pool_full.duplicate()
	weapon_pool.append("homer")
	$HBoxContainer/itemcon/item.text = items[items_index]
	
	if items[items_index] == "coin":
		nam = " "
		$HBoxContainer/namcon/namicon.texture = load("res://assets/loot/generic/coin.png")
		$HBoxContainer/namcon/namup.hide()
		$HBoxContainer/namcon/namdown.hide()
	elif items[items_index] == "potion":
		nam = " "
		$HBoxContainer/namcon/namicon.texture = load("res://assets/loot/generic/potion.png")
		$HBoxContainer/namcon/namup.hide()
		$HBoxContainer/namcon/namdown.hide()
	elif items[items_index] == "item":
		nam = item_pool[item_index]
		$HBoxContainer/namcon/namicon.texture = load("res://assets/loot/items/"+item_pool[item_index]+".png")
		$HBoxContainer/namcon/namup.show()
		$HBoxContainer/namcon/namdown.show()
	elif items[items_index] == "weapon":
		nam = weapon_pool[weapon_index]
		$HBoxContainer/namcon/namicon.texture = load("res://assets/loot/weapons/"+weapon_pool[weapon_index]+".png")
		$HBoxContainer/namcon/namup.show()
		$HBoxContainer/namcon/namdown.show()

func _on_itemup_pressed():
	if items_index == 0:
		items_index = 3
	else:
		items_index -= 1

func _on_itemup_focus_entered():
	$HBoxContainer/itemcon/itemup.modulate = Color(190/255.0,118/255.0,253/255.0, 1)

func _on_itemup_focus_exited():
	$HBoxContainer/itemcon/itemup.modulate = Color(1,1,1,1)

func _on_itemdown_pressed():
	if items_index == 3:
		items_index = 0
	else:
		items_index += 1

func _on_itemdown_focus_entered():
	$HBoxContainer/itemcon/itemdown.modulate = Color(190/255.0,118/255.0,253/255.0, 1)

func _on_itemdown_focus_exited():
	$HBoxContainer/itemcon/itemdown.modulate = Color(1,1,1,1)

func _on_nameup_pressed():
	if items[items_index] == "item":
		if item_index == 0:
			item_index = len(item_pool)-1
		else:
			item_index -= 1
	elif items[items_index] == "weapon":
		if weapon_index == 0:
			weapon_index = len(weapon_pool)-1
		else:
			weapon_index -= 1

func _on_nameup_focus_entered():
	$HBoxContainer/namcon/namup.modulate = Color(190/255.0,118/255.0,253/255.0, 1)

func _on_nameup_focus_exited():
	$HBoxContainer/namcon/namup.modulate = Color(1,1,1,1)

func _on_namdown_pressed():
	if items[items_index] == "item":
		if item_index == len(item_pool)-1:
			item_index = 0
		else:
			item_index += 1
	elif items[items_index] == "weapon":
		if weapon_index == len(weapon_pool)-1:
			weapon_index = 0
		else:
			weapon_index += 1

func _on_namdown_focus_entered():
	$HBoxContainer/namcon/namdown.modulate = Color(190/255.0,118/255.0,253/255.0, 1)

func _on_namdown_focus_exited():
	$HBoxContainer/namcon/namdown.modulate = Color(1,1,1,1)

func _on_spawn_pressed():
	Glova.spawn_vars = [items[items_index], nam]
	
	get_tree().paused = false

func _on_spawn_focus_entered():
	$HBoxContainer/spawn.modulate = Color(190/255.0,118/255.0,253/255.0, 1)

func _on_spawn_focus_exited():
	$HBoxContainer/spawn.modulate = Color(1,1,1,1)
