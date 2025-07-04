extends CharacterBody2D

@export var projectile_scene: PackedScene
@export var tower_scene: PackedScene
@export var projectile_speed: float = 400.0
@export var ui: Node  # reference na UI
#@export var tower_offset: Vector2 = Vector2(0, 50)

var SPEED = Config.player_speed
const JUMP_VELOCITY = -400.0

var shoot_cooldown: float = Config.player_shot_cd  # v sekundách
var is_in_tower: bool = false
var can_shoot: bool = true

var timer: Timer
var tower_inventory = Config.player_starting_tower_count

func _ready():
	timer = Timer.new()
	timer.name = "ShootCooldownTimer"
	timer.one_shot = true
	timer.wait_time = shoot_cooldown
	add_child(timer)
	timer.timeout.connect(_on_shoot_cooldown_timeout)
	
	update_ui()

func _process(delta):
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot_projectile()
	if Input.is_action_just_pressed("spawn_tower") and not is_in_tower:
		spawn_tower()

func _physics_process(delta: float) -> void:
	rotation = 0
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()



func shoot_projectile():
	var projectile = projectile_scene.instantiate()
	get_parent().add_child(projectile)
	projectile.position = self.global_position + Vector2(0,-20)
	can_shoot = false
	timer.start()
	#projectile.velocity = Vector2.RIGHT.rotated(rotation) * projectile_speed
	
func _on_shoot_cooldown_timeout():
	can_shoot = true

func spawn_tower():
	if (tower_inventory > 0):
		tower_inventory -= 1
		var tower = tower_scene.instantiate()
		
		update_ui()
		
		get_parent().add_child(tower)
		tower.global_position = self.global_position + Vector2(0,-30)
	
func add_tower_to_inventory():
	tower_inventory += 1
	update_ui()
	print("Věž přidána do inventáře. Celkem: ")
	
func update_ui():
	if ui:
		ui.update_tower_display(tower_inventory)
