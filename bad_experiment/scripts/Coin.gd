extends Area2D

var window_size

func _ready():
	$Timer.wait_time = rand_range(1, 3)
	$Timer.start()

	$Tween.interpolate_property($AnimatedSprite, 'position', 
	$AnimatedSprite.position, 
	Vector2(0, -50), 1.0, Tween.TRANS_LINEAR, 
	Tween.EASE_OUT)
	
	$Tween.interpolate_property($AnimatedSprite, 'modulate',
	Color(1, 1, 1, 1),
	Color(1, 1, 1, 0), 0.3,
	Tween.TRANS_LINEAR,
	Tween.EASE_OUT)

func pickup():
	monitoring = false
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	self.queue_free()

func _on_Coin_area_entered(area):
	if area.is_in_group("enemy"):
		position = Vector2(position.x + rand_range(-20, 20), 
			position.y + rand_range(-20, 20))
		#Vector2(position.x + 10, position.y + 10) #_G.rand()

func _on_Timer_timeout():
	$AnimatedSprite.frame = 0
	$AnimatedSprite.play()