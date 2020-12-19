extends RigidBody2D


# min and max speed
export var min_speed = 150
export var max_speed = 250

func _ready():
	var mob_types = $AnimatedSprite.frames.get_animation_names() # get the different available animations
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()] # loop through the values and pick a random animation
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free() # delete player when he quits the screen
