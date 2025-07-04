extends Node2D

@export var enemy: PackedScene

# nahradit configem
@export var enemies_per_wave: int = Config.enemies_per_wave
@export var time_between_waves: float = Config.wave_timer

var current_wave: int = 1
var wave_timer: Timer
var enemy_spawner: Node2D 

func _ready():
	enemy_spawner = self

	wave_timer = Timer.new()
	wave_timer.wait_time = time_between_waves
	wave_timer.timeout.connect(spawn_wave)
	wave_timer.one_shot = false
	add_child(wave_timer)
	wave_timer.start()

	spawn_wave()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func spawn_wave():
	print("Spawning wave:", current_wave)
	for i in range(enemies_per_wave * current_wave):
		spawn_enemy()
	current_wave += 1

func spawn_enemy():
	var enemyModel = enemy.instantiate()
	add_child(enemyModel)
	enemyModel.position = Vector2(randi_range(-20, 20), -5)
	
	
