extends KinematicBody2D

const MOVE_SPEED = 50

const MAX_HEALTH = 50
var health = MAX_HEALTH

func adjust_health(health_adjustment):
	if health_adjustment < 0:
		$hit_sound.play()
	health += health_adjustment
	if health > MAX_HEALTH:
		health = MAX_HEALTH
	$health_bar.visible = health != MAX_HEALTH
	$health_bar.set_health(health, MAX_HEALTH)
	if health <= 0:
		queue_free()

func _process(delta):
	if !get_node("../../ui/menu_popup").visible and !get_node("../../ui/gameover_popup").visible:
		var player = get_node("../../player")
		var movement = Vector2()
		movement.x = (sign(player.position.x - position.x) + [-1, 1][randi() % 2]) * MOVE_SPEED * delta
		movement.y = (sign(player.position.y - position.y) + [-1, 1][randi() % 2]) * MOVE_SPEED * delta
		move_and_collide(movement)