tool
extends Node 

export (PackedScene) var Slime
export (int) var playtime
var level
var score
var time_left
var window_size
var playing = false

func _ready():
	randomize()
	window_size = get_viewport().get_visible_rect().size #OS.window_size
	$Player.window_size = window_size
	$Player.hide()

func spawn_coins():
	for i in range(4 + level):
		var c = Slime.instance()
		$SlimeContaner.add_child(c)
		c.window_size = window_size
		c.position = _G.rand()
	
func new_game():
	playing = true
	level = 1
	score = 0
	time_left = playtime
	$Player.start($PlayerPosition.position)
	$Player.show()
	$Enemy.position = _G.rand()
	$Enemy.show()
	$GameTimer.start()
	spawn_coins()
	$Enemy.set_process(true)
	$Enemy.spritedir_loop()
	$HUD.update_score(score)
	$HUD.update_timer(time_left)
	$Enemy.speed = 50
	
func game_over():
	playing = false
	$GameTimer.stop()
	for coin in $SlimeContaner.get_children():
		coin.queue_free()
	$HUD.show_game_over()
	$Player.die()
	$Enemy.die()

func _process(delta):
	if playing and $SlimeContaner.get_child_count() == 0:
		level += 1
		$HUD.update_level(level)
		time_left += 5
		$Enemy.speed += 10 
		$Enemy.spritedir_loop()
		spawn_coins()

func _on_GameTimer_timeout():
	time_left -= 1
	$HUD.update_timer(time_left)
	if time_left <= 0:
		game_over()

func _on_Player_die():
	game_over()

func _on_Player_pickup():
	score += 1
	$HUD.update_score(score)
