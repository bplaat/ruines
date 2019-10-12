extends KinematicBody2D

const MOVE_SPEED = 200

const MAX_HEALTH = 200
var health = MAX_HEALTH

var bullet = preload("res://scenes/bullet.tscn")

var aliens_close = 0

func adjust_health(health_adjustment):
	if health_adjustment > 0:
		$health_sound.play()
	health += health_adjustment
	if health > MAX_HEALTH:
		health = MAX_HEALTH
	$health_bar.visible = health != MAX_HEALTH
	$health_bar.set_health(health, MAX_HEALTH)
	get_node("../ui/bar/health_label").text = str("Health: ", round((float(health) / MAX_HEALTH) * 100), "%")
	if health <= 0:
		get_node("../ui/gameover_popup").visible = true

func _on_damage_area_body_entered(body):
	if "@alien" in body.get_name():
		aliens_close += 1

func _on_damage_area_body_exited(body):
	if "@alien" in body.get_name():
		aliens_close -= 1

func _process(delta):
	if !get_node("../ui/menu_popup").visible and !get_node("../ui/gameover_popup").visible:
		var damage = 0
		for i in range(0, aliens_close):
			if randi() % 3 == 1:
				damage -= 1
		if damage < 0:
			adjust_health(damage)
			$hurt_sound.play()
		
		var movement = Vector2()
		if Input.is_action_pressed("player_left"):
			movement.x = -MOVE_SPEED * delta
		if Input.is_action_pressed("player_up"):
			movement.y = -MOVE_SPEED * delta
		if Input.is_action_pressed("player_right"):
			movement.x = MOVE_SPEED * delta
		if Input.is_action_pressed("player_down"):
			movement.y = MOVE_SPEED * delta
		move_and_collide(movement)
		
		if Input.is_action_just_pressed("player_shoot") and get_viewport().get_mouse_position().y < 720 - get_node("../ui/bar").rect_size.y and $timer.time_left == 0:
			var new_bullet = bullet.instance()
			new_bullet.position = position + $gun.position
			new_bullet.rotation = rotation + $gun.rotation
			get_node("../bullets").add_child(new_bullet)
			$shoot_sound.play()
			$timer.start()
		
		$gun.rotation = atan2(get_global_mouse_position().y - position.y, get_global_mouse_position().x - position.x)
		if $gun.rotation > PI / 2 or $gun.rotation < -PI / 2:
			$gun.scale.y = -1
		else:
			$gun.scale.y = 1
