extends Node2D

var game = 0
var posizioni = []
var posizioni2 = []
var used = []
var i = 0
var time = 0
var disabled = 0
var faces = []
var win = 0
var timeStart = 0
var timeActive = false

func _ready():
	scrumble()

func _process(delta):
	if timeActive:
		timeUpdate(timeStart)
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
		timeActive = false
		isRecord($time.text, $record.text)
		if Input.is_key_pressed(KEY_ESCAPE):
			win = 0
			$winLabel.hide()
			$down.show()
			$down2.show()
			$up.show()
			$up2.show()
			$left.show()
			$left2.show()
			$right.show()
			$right2.show()
			$NinePatchRect.show()
			$time.show()
			$record.show()
			$start.show()
			$scrumble.show()

func _on_scrumble_scrumble():
	changeTime()
	_ready()

func changeTime():
	var temp = OS.get_time()
	time = temp["hour"] * temp["minute"] * temp["second"]
	return str(time).hash()

func scrumble():
	seed(changeTime())
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

func _on_start_button_up():
	scrumble()
	timeStart = OS.get_time()
	timeStart = timeStart["hour"] * 3600 + timeStart["minute"] * 60 + timeStart["second"]
	timeActive = true

func timeUpdate(rif):
	var mytime = OS.get_time()["hour"] * 3600 + OS.get_time()["minute"] * 60 + OS.get_time()["second"]
	var delta = mytime - rif
	if delta > 3600:
		mytime = [delta / 3600]
		delta -= mytime[0] * 3600
		mytime.append(delta / 60)
		delta -= mytime[1] * 60
		mytime.append(delta)
	elif delta >= 60:
		mytime = [0]
		mytime.append(delta / 60)
		delta -= mytime[1] * 60
		mytime.append(delta)
	else:
		mytime = [0,0,delta]
	mytime[0] = str(mytime[0])
	mytime[1] = str(mytime[1])
	mytime[2] = str(mytime[2])
	if len(mytime[0]) == 1:
		mytime[0] = "0" + mytime[0]
	if len(mytime[1]) == 1:
		mytime[1] = "0" + mytime[1]
	if len(mytime[2]) == 1:
		mytime[2] = "0" + mytime[2]
	var timeString = "Time:\n" + mytime[0] + ":" + mytime[1] + ":" + mytime[2]
	$time.text = timeString

func isRecord(time, record):
	var current = int(time[-8] + time[-7]) * 3600 + int(time[-5] + time[-4]) * 60 + int(time[-2] + time[-1])
	var oldRecord = int(record[-8] + record[-7]) * 3600 + int(record[-5] + record[-4]) * 60 + int(record[-2] + record[-1])
	if game == 0 or current < oldRecord:
		record[-8] = time[-8]
		record[-7] = time[-7]
		record[-6] = time[-6]
		record[-5] = time[-5]
		record[-4] = time[-4]
		record[-3] = time[-3]
		record[-2] = time[-2]
		record[-1] = time[-1]
		$record.text = record
	else:
		$record.text = record
	game += 1