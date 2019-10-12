extends ColorRect

func set_health(health, max_health):
	$green_bar.rect_size.x = (float(health) / max_health) * $red_bar.rect_size.x
