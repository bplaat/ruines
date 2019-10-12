extends Node2D

const MAP_WIDTH = 100
const MAP_HEIGHT = 100

const TILE_SIZE = 64
const RUIN_SIZE = 128

const OBJECT_COUNT = (MAP_WIDTH * MAP_HEIGHT) / 35
const RUIN_COUNT = (MAP_WIDTH * MAP_HEIGHT) / 50
const ALIEN_COUNT = (MAP_WIDTH * MAP_HEIGHT) / 200

var kit = preload("res://scenes/kit.tscn")
var tree = preload("res://scenes/tree.tscn")
var bushes = preload("res://scenes/bushes.tscn")
var rocks = preload("res://scenes/rocks.tscn")
var house = preload("res://scenes/house.tscn")
var church = preload("res://scenes/church.tscn")
var alien = preload("res://scenes/alien.tscn")

var score = 0

func _ready():
	randomize()
	
	for y in range(-1, MAP_HEIGHT + 1):
		for x in range(-1, MAP_WIDTH + 1): 
			$terrain_tilemap.set_cell(x, y, 2)
	
	for y in range(0, MAP_HEIGHT):
		for x in range(0, MAP_WIDTH):
			$terrain_tilemap.set_cell(x, y, 0)
	
	for x in range(0, MAP_WIDTH): 
			$terrain_tilemap.set_cell(x, MAP_HEIGHT / 2, 1)
	
	for i in range(0, RUIN_COUNT):
		var new_kit = kit.instance()
		new_kit.position.x = (randi() % ((MAP_WIDTH - 2) * TILE_SIZE)) + TILE_SIZE / 2
		new_kit.position.y = (randi() % ((MAP_HEIGHT - 2) * TILE_SIZE)) + TILE_SIZE / 2
		$objects.add_child(new_kit)
	
	for i in range(0, OBJECT_COUNT):
		var new_tree = tree.instance()
		new_tree.position.x = (randi() % ((MAP_WIDTH - 2) * TILE_SIZE)) + TILE_SIZE / 2
		new_tree.position.y = (randi() % ((MAP_HEIGHT - 2) * TILE_SIZE)) + TILE_SIZE / 2
		$objects.add_child(new_tree)
	
	for i in range(0, OBJECT_COUNT):
		var new_bushes = bushes.instance()
		new_bushes.position.x = (randi() % ((MAP_WIDTH - 2) * TILE_SIZE)) + TILE_SIZE / 2
		new_bushes.position.y = (randi() % ((MAP_HEIGHT - 2) * TILE_SIZE)) + TILE_SIZE / 2
		$objects.add_child(new_bushes)
	
	for i in range(0, OBJECT_COUNT):
		var new_rocks = rocks.instance()
		new_rocks.position.x = (randi() % ((MAP_WIDTH - 2) * TILE_SIZE)) + TILE_SIZE / 2
		new_rocks.position.y = (randi() % ((MAP_HEIGHT - 2) * TILE_SIZE)) + TILE_SIZE / 2
		$objects.add_child(new_rocks)
	
	for i in range(0, RUIN_COUNT):
		var new_house = house.instance()
		new_house.position.x = (randi() % ((MAP_WIDTH - 2) * RUIN_SIZE)) + RUIN_SIZE / 2
		new_house.position.y = (randi() % ((MAP_HEIGHT - 2) * RUIN_SIZE)) + RUIN_SIZE / 2
		$objects.add_child(new_house)
	
	for i in range(0, RUIN_COUNT):
		var new_church = church.instance()
		new_church.position.x = (randi() % ((MAP_WIDTH - 2) * RUIN_SIZE)) + RUIN_SIZE / 2
		new_church.position.y = (randi() % ((MAP_HEIGHT - 2) * RUIN_SIZE)) + RUIN_SIZE / 2
		$objects.add_child(new_church)
	
	for i in range(0, ALIEN_COUNT):
		var new_alien = alien.instance()
		new_alien.position.x = (randi() % ((MAP_WIDTH - 2) * TILE_SIZE)) + TILE_SIZE / 2
		new_alien.position.y = (randi() % ((MAP_HEIGHT - 2) * TILE_SIZE)) + TILE_SIZE / 2
		$objects.add_child(new_alien)

func _process(delta):
	if !$ui/menu_popup.visible and !$ui/gameover_popup.visible:
		score += 1
		$ui/bar/score_label.text = str("Score: ", str(score).pad_zeros(6))
		$ui/gameover_popup/score_label.text = str("Score: ", str(score).pad_zeros(6))

func _on_timer_timeout():
	var new_alien = alien.instance()
	new_alien.position.x = (randi() % ((MAP_WIDTH - 1) * TILE_SIZE)) + TILE_SIZE / 2
	new_alien.position.y = (randi() % ((MAP_HEIGHT - 1) * TILE_SIZE)) + TILE_SIZE / 2
	$objects.add_child(new_alien)
	$timer.start()

func _on_menu_button_pressed():
	$ui/menu_popup.visible = true

func _on_resume_button_pressed():
	$ui/menu_popup.visible = false

func _on_exit_button_pressed():
	get_tree().change_scene("res://scenes/menu_scene.tscn")


