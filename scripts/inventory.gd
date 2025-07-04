extends Control

@onready var tower_grid = self
@export var tower_texture: Texture2D  # přiřaď obrázek věže v editoru

var slot_array: Array = []
var tower_size := Vector2(64, 64)  # výchozí velikost každé věže v pixelech

func _ready() -> void:
	var slots = Config.inventory_slots
	get_parent().get_parent().size=Vector2(64*slots, 64)
	for i in slots:
		var icon = TextureRect.new()
		icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
		icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
		icon.custom_minimum_size = tower_size
		tower_grid.add_child(icon)
		slot_array.append(icon)
		
func update_tower_display(count: int):
	var i = 0
	for icon in slot_array:
		icon.texture = null	
		if i < count:
			icon.texture = tower_texture
		i+=1
