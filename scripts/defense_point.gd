extends Area2D

#set to config
var hp := Config.portal_hp 

func _ready():
	body_entered.connect(_body_entered)

func _body_entered(body: Node) -> void:
	if body.is_in_group("enemies"):
		hp -= 1
		print("Point hit! HP left: %d" % hp)
		body.queue_free()
		if hp <= 0:
			get_tree().reload_current_scene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
