extends Node

export (PackedScene) var Enemy
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func game_over():
	$ScoreTimer.stop()
	$EnemyTimer.stop()
	$Music.stop()
	$DeathSound.play()
	$HUD.show_game_over()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$Music.play()
	$HUD.show_message("Get Ready!")


func _on_StartTimer_timeout():
	$ScoreTimer.start()
	$EnemyTimer.start()


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_EnemyTimer_timeout():
	
	$enemyPath/enemySpawnLocation.offset = randi()
	
	var enemy = Enemy.instance()
	add_child(enemy)
	
	var direction = $enemyPath/enemySpawnLocation.rotation + PI/2
	
	enemy.position = $enemyPath/enemySpawnLocation.position
	
	direction += rand_range(-PI/4, PI/4)
	enemy.rotation = direction
	
	enemy.linear_velocity = Vector2(rand_range(enemy.min_speed, enemy.max_speed), 0)
	enemy.linear_velocity = enemy.linear_velocity.rotated(direction)
