extends Area2D

func _on_kit_body_entered(body):
	if "player" in body.get_name():
		get_node("../../").score += 100
		body.adjust_health(10)
		queue_free()
