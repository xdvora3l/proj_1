extends Area2D

@export var speed: float = 1.0

var dmg = Config.shot_dmg

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta):
	position += (Vector2(global_position.x, 0) - Vector2.ZERO).normalized() * speed
	if((self.global_position - Vector2.ZERO).x > 0):
		rotation = 0
	else:
		rotation = PI

func _on_body_entered(body):
	print("something")
	if body.is_in_group("enemies"):
		print("hit")
		body.take_damage(dmg)
		queue_free()
		
	
