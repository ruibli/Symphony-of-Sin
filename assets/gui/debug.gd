extends Control

@export var pedestal_scene: PackedScene

var item = "coin"
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
	item_pool = Glova.g_item_pool("0")
	weapon_pool = Glova.g_weapon_pool("0")
	
	if item == "coin":
		nam = " "
	elif item == "potion":
		nam = " "
	elif item == "item":
		nam = item_pool[item_index]
	elif item == "weapon":
		nam = weapon_pool[weapon_index]
		
	$HBoxContainer/itemcon/item.text = items[items_index]
	$HBoxContainer/namcon/nam.text = nam
	
func spawn():
	var temp = pedestal_scene.instantiate()
	temp.position = Vector2(0,0)
	temp.type = "debug"
	temp.item = item
	temp.nam = nam
	add_child(temp)

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
	if item == "item":
		if item_index == len(item_pool)-1:
			item_index = 0
		else:
			item_index += 1
	elif item == "weapon":
		if weapon_index == len(weapon_pool)-1:
			weapon_index = 0
		else:
			weapon_index += 1

func _on_nameup_focus_entered():
	$HBoxContainer/namcon/namup.modulate = Color(190/255.0,118/255.0,253/255.0, 1)

func _on_nameup_focus_exited():
	$HBoxContainer/namcon/namup.modulate = Color(1,1,1,1)

func _on_namdown_pressed():
	if item == "item":
		if item_index == 0:
			item_index = len(item_pool)-1
		else:
			item_index -= 1
	elif item == "weapon":
		if weapon_index == 0:
			weapon_index = len(weapon_pool)-1
		else:
			weapon_index -= 1

func _on_namdown_focus_entered():
	$HBoxContainer/namcon/namdown.modulate = Color(190/255.0,118/255.0,253/255.0, 1)

func _on_namdown_focus_exited():
	$HBoxContainer/namcon/namdown.modulate = Color(1,1,1,1)
