extends Node2D

var posizioni = []
var posizioni2 = []
var used = []
var i = 0
var time = 0

func _ready():
	scrumble()

func _process(delta):
	pass

func _on_scrumble_scrumble():
	changeTime()
	_ready()

func changeTime():
	var temp = OS.get_time()
	time = temp["hour"] * temp["minute"] * temp["second"]
	return str(time).hash()

func scrumble():
	seed(changeTime())
	print(changeTime())
	posizioni = [Vector2(125,100),
				Vector2(250,100),
				Vector2(375,100),
				Vector2(500,100),
				Vector2(125,200),
				Vector2(250,200),
				Vector2(375,200),
				Vector2(500,200)]
	used = []
	posizioni2 = []
	i = 0
	while(i < 8):
		var a = randi() % 8
		if a in used:
			continue
		else:
			used.append(a)
			posizioni2.append(posizioni[a])
			i += 1
	print(posizioni2)
	$down.position = posizioni2[0]
	$down2.position = posizioni2[1]
	$up.position = posizioni2[2]
	$up2.position = posizioni2[3]
	$right.position = posizioni2[4]
	$right2.position = posizioni2[5]
	$left.position = posizioni2[6]
	$left2.position = posizioni2[7]