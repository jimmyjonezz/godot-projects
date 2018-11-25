extends Area2D

signal pickup
signal die

export (int) var speed
var velocity = Vector2()
var window_size = Vector2(800, 600)

func _ready():
	pass

func start(pos):
	set_process(true)
	position = pos
	$AnimatedSprite.animation = "idle"

func _input(event):
	if Input.is_action_pressed("ui_down"):
		if !$step.is_playing():
			$step.play()
	if Input.is_action_just_released("ui_down"):
		if $step.is_playing():
			$step.stop()
	if Input.is_action_pressed("ui_up"):
		if !$step.is_playing():
			$step.play()
	if Input.is_action_just_released("ui_up"):
		if $step.is_playing():
			$step.stop()
	if Input.is_action_pressed("ui_left"):
		if !$step.is_playing():
			$step.play()
	if Input.is_action_just_released("ui_left"):
		if $step.is_playing():
			$step.stop()
	if Input.is_action_pressed("ui_right"):
		if !$step.is_playing():
			$step.play()
	if Input.is_action_just_released("ui_right"):
		if $step.is_playing():
			$step.stop()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	if velocity.length() > 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_h = velocity.x < 0
	else:
		$AnimatedSprite.animation = "idle"

func _process(delta):
	get_input()
	
	position += velocity * delta
	position.x = clamp(position.x, 60, 740)
	position.y = clamp(position.y, 60, 540)

func _on_Area2D_area_entered(area):
	if area.is_in_group("coins"):
		emit_signal("pickup")
		area.pickup()
	if area.is_in_group("enemy"):
		emit_signal("die")
		area.die()

func die():
	$AnimatedSprite.animation = "die"
	set_process(false)