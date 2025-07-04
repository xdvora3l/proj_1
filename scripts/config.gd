extends Node
class_name InventorySettings

const CONFIG_PATH = "user://config.cfg"

var inventory_slots: int = 3 
var enemies_per_wave: int = 3 
var wave_timer: float = 10 

var enemy_hp: int = 3 
var enemy_drop_chance: int = 75
var enemy_min_speed: int = 50
var enemy_max_speed: int = 150   

var portal_hp: int = 10

var player_speed: float = 350
var player_shot_cd: float = 0.5
var player_starting_tower_count: float = 1


var tower_shot_cd: float = 0.75


var shot_dmg: int = 10

func _ready() -> void:
	if FileAccess.file_exists("user://config.cfg"):
		load_config()
		print("Config exists!")
	else:
		print("Config missing — saving defaults...")
		save_config()
	

func load_config():
	var config = ConfigFile.new()
	var err = config.load(CONFIG_PATH)
	if err == OK:
		for prop in get_property_list():
			if prop.name in ["script"]:  # vynechat interní vlastnosti
				continue
			var value = config.get_value("game", prop.name, get(prop.name))
			set(prop.name, value)

func save_config():
	var config = ConfigFile.new()
	for prop in get_property_list():
		if prop.name in ["script"]:  # vynechat interní vlastnosti
			continue
		config.set_value("game", prop.name, get(prop.name))
	config.save(CONFIG_PATH)
