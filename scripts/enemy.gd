extends CharacterBody2D

#config
var Hp: float = 50

const SPEED = 1.0
const JUMP_VELOCITY = -400.0


func _ready():
	pass

func _physics_process(delta: float) -> void:
	# Add gravity if the character is not on the floor
	if not is_on_floor():
		velocity += get_gravity() * delta
	look_at(get_parent().global_position)
	# Get the direction vector from the character to the portal
	var direction_to_portal = get_parent().global_position - self.get_parent().global_position

# Move the character towards the portal
	velocity.x = direction_to_portal.x * SPEED
	#velocity.y = move_toward(velocity.y, direction_to_portal.y, SPEED * delta)

	move_and_slide()
