extends Area2D

const MOVE_SPEED = 600
var speed = MOVE_SPEED

func _process(delta):
	move_local_x(speed * delta)

func _on_bullet_body_entered(body):
	if (
		"tree" in body.get_name() or
		"bushes" in body.get_name() or
		"rocks" in body.get_name() or
		"house" in body.get_name() or
		"church" in body.get_name() or
		"alien" in body.get_name()
	):
		body.adjust_health(-randi() % 15 - 10)
	if body.get_name() != "player":
		queue_free()

func _on_timer_timeout():
	queue_free()
