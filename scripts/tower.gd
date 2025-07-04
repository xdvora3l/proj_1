extends Area2D

@export var projectile_scene: PackedScene
@export var projectile_speed: float = 400.0

var shoot_cooldown: float = Config.tower_shot_cd  # v sekundách
var can_shoot: bool = true
var timer: Timer

func _ready():
	timer = Timer.new()
	timer.name = "ShootCooldownTimer"
	timer.one_shot = true
	timer.wait_time = shoot_cooldown
	add_child(timer)
	timer.timeout.connect(_on_shoot_cooldown_timeout)
	
func _on_body_entered(body):
	if body.name == "Player":
		body.is_in_tower = true

func _on_body_exited(body):
	if body.name == "Player":
		body.is_in_tower = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_shoot:
		spawn_projectile()
	
func spawn_projectile():
	var projectile = projectile_scene.instantiate()
	can_shoot = false
	timer.start()
	get_parent().add_child(projectile)
	projectile.position = self.global_position + Vector2(0,-0)
	
func _on_shoot_cooldown_timeout():
	can_shoot = true
