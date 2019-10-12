extends StaticBody2D

const MAX_HEALTH = 100
var health = MAX_HEALTH

func adjust_health(health_adjustment):
	if health_adjustment < 0:
		$explosion_sound.play()
	health += health_adjustment
	if health > MAX_HEALTH:
		health = MAX_HEALTH
	$health_bar.visible = health != MAX_HEALTH
	$health_bar.set_health(health, MAX_HEALTH)
	if health <= 0:
		queue_free()