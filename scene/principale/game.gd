extends Node2D

var posizioni = []
var posizioni2 = []
var used = []
var i = 0
var time = 0
var disabled = 0
var faces = []
var win = 0

func _ready():
	scrumble()

func _process(delta):
	if $down.pressed:
		$down.set_disabled(true)
		disabled += 1
		faces.append("down")
	elif $down2.pressed:
		$down2.set_disabled(true)
		disabled += 1
		faces.append("down")
	elif $up.pressed:
		$up.set_disabled(true)
		disabled += 1
		faces.append("up")
	elif $up2.pressed:
		$up2.set_disabled(true)
		disabled += 1
		faces.append("up")
	elif $right.pressed:
		$right.set_disabled(true)
		disabled += 1
		faces.append("right")
	elif $right2.pressed:
		$right2.set_disabled(true)
		disabled += 1
		faces.append("right")
	elif $left.pressed:
		$left.set_disabled(true)
		disabled += 1
		faces.append("left")
	elif $left2.pressed:
		$left2.set_disabled(true)
		disabled += 1
		faces.append("left")
	if disabled == 2:
		if faces[0] == faces[1]:
			disabled = 0
			faces = []
			win += 1
		elif faces[0] != faces[1]:
			disabled = 0
			faces = []
			win = 0
			yield(get_tree().create_timer(1.0), "timeout")
			$down.set_disabled(false)
			$down2.set_disabled(false)
			$up.set_disabled(false)
			$up2.set_disabled(false)
			$right.set_disabled(false)
			$right2.set_disabled(false)
			$left.set_disabled(false)
			$left2.set_disabled(false)
	if win == 4:
		$winLabel.show()
		$down.hide()
		$down2.hide()
		$up.hide()
		$up2.hide()
		$left.hide()
		$left2.hide()
		$right.hide()
		$right2.hide()
		$NinePatchRect.hide()
		$time.hide()
		$record.hide()
		$start.hide()
		$scrumble.hide()

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
	posizioni = [Vector2(125,50),
				Vector2(250,50),
				Vector2(375,50),
				Vector2(500,50),
				Vector2(125,150),
				Vector2(250,150),
				Vector2(375,150),
				Vector2(500,150)]
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
	$down.rect_position = posizioni2[0]
	$down2.rect_position = posizioni2[1]
	$up.rect_position = posizioni2[2]
	$up2.rect_position = posizioni2[3]
	$right.rect_position = posizioni2[4]
	$right2.rect_position = posizioni2[5]
	$left.rect_position = posizioni2[6]
	$left2.rect_position = posizioni2[7]
	$down.set_disabled(false)
	$down2.set_disabled(false)
	$up.set_disabled(false)
	$up2.set_disabled(false)
	$right.set_disabled(false)
	$right2.set_disabled(false)
	$left.set_disabled(false)
	$left2.set_disabled(false)