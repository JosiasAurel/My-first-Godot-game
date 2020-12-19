extends Area2D

# signals
signal hit

export var speed = 400 # the speed/how fast the player will move in pixels/second
var screen_size # size of game window

func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _process(delta):
	var velocity = Vector2() # the player moves on the 2D plane
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized()*speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	# clamp the player to the screen
	position += velocity*delta
	position.x = clamp(position.x, 0, screen_size.x) # clamp on x axis
	position.y = clamp(position.y, 0, screen_size.y) # clamp on y axis
	
	# make sure to be flipping the player animation frame depending on the movement
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0



func _on_Player_body_entered(body):
	hide() # make player dissapear when hit
	emit_signal("hit")
	$CollisionShape2D.set_deferred("dissabled", true)
	
# function to init player when starting or restarting the game
func start(pos):
	position = pos
	show() # display the player on the screen
	$CollisionShape2D.disabled = false # activate player collision
