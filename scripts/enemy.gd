extends CharacterBody2D

#config
var Hp: float = Config.enemy_hp

#const SPEED = 250.0
const JUMP_VELOCITY = -400.0


func _ready():
	add_to_group("enemies")
	
func _process(delta):
	pass

func _physics_process(delta: float) -> void:
	if Hp < 0:
		return
	$AnimatedSprite2D.play("Move")
	var speed = randi_range(Config.enemy_min_speed,Config.enemy_max_speed)
	rotation = 0
	if not is_on_floor():
		velocity += get_gravity() * delta
	#look_at(self.get_parent().get_parent().get_node('Portal').global_position)
	var direction_to_portal = Vector2(0,0) - self.global_position

	if direction_to_portal.normalized().x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
		
	velocity.x = direction_to_portal.normalized().x * speed
	move_and_slide()
	
func take_damage(amount: int):
	Hp -= amount
	if Hp <= 0:
		give_tower_to_player()
		$AnimatedSprite2D.play("Death")
		await get_tree().create_timer(0.5).timeout
		queue_free()
		

func give_tower_to_player():
	var player = self.get_parent().get_parent().get_node('Player')
	if player and randi_range(0,100) > Config.enemy_drop_chance and player.tower_inventory < Config.inventory_slots:
		player.add_tower_to_inventory()
