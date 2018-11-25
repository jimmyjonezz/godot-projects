extends Area2D

var movetimer = 0
var movetimer_lenght = 400
var velocity = Vector2()
var speed = 50
var window_size = Vector2(800, 600)

func spritedir_loop():
	var d = randi() % 5
	match d:
		0:
			velocity.x = 0
			velocity.y = 0
		1:
			velocity.x += 1
		2:
			velocity.x -= 1
		3:
			velocity.y += 1
		4:
			velocity.y -= 1

func _process(delta):
	if velocity.length() > 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_h = velocity.x < 0
	else:
		$AnimatedSprite.animation = "idle"
	
	velocity = velocity.normalized() * speed * delta
	
	if position.x == 100 || position.y == 500:
		spritedir_loop()
	
	if position.x == 700 || position.y == 100:
		spritedir_loop()
	
	position += velocity
	
	position.x = clamp(position.x, 100, window_size.x - 100)
	position.y = clamp(position.y, 100, window_size.y - 100)
	
	if movetimer > 0:
		movetimer -= 1
	if movetimer == 0:
		spritedir_loop()
		movetimer = movetimer_lenght

func die():
	self.visible = false
	set_process(false)