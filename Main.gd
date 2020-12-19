extends Node


export (PackedScene) var Mob
var score

func _ready():
	randomize()
	#new_game()

# when the player is hit
func _on_game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	get_tree().call_group("Mob", "queue_free")
	$GameMusic.stop()
	$DeathMusic.play()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$GameMusic.play()


func _on_MobTimer_timeout():
	# choose a random loacation on Path2D
	$MobPath/MobSpawnLocation.offset = randi()
	# instantiate a mob
	var new_mob = Mob.instance()
	add_child(new_mob) # add the new mob to the scene
	# set direction perpendicular to the path direction
	var direction = $MobPath/MobSpawnLocation.rotation + PI/2
	# set mob location to a random location
	new_mob.position = $MobPath/MobSpawnLocation.position
	# spice up the location randomness
	direction = rand_range(-PI/4, PI/4)
	new_mob.rotation = direction
	# set the velocity
	new_mob.linear_velocity = Vector2(rand_range(new_mob.min_speed, new_mob.max_speed), 0)
	new_mob.linear_velocity = new_mob.linear_velocity.rotated(direction)


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
