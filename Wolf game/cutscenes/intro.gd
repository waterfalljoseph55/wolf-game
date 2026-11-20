extends Control
## Plays the opening cinematic, then loads the next scene.
## Hold Space/Enter (ui_accept) for about a second to skip.

## The scene to load when the intro ends or is skipped. Set this to your menu or first level.
@export_file("*.tscn") var next_scene := ""
## The recorded intro video (Ogg Theora). Leave the path as-is once you add the file.
@export_file("*.ogv") var video_path := "res://cutscenes/intro.ogv"
## Set true if the .ogv already has the soundtrack mixed in, so it isn't played twice.
@export var video_has_audio := false

@onready var video: VideoStreamPlayer = $VideoStreamPlayer
@onready var soundtrack: AudioStreamPlayer = $Soundtrack

## Extra sounds: [seconds into the intro, AudioStreamPlayer node name].
## Add an AudioStreamPlayer child to this scene and list it here.
var cues := []
var next_cue := 0
var hold_time := 0.0
var leaving := false
var elapsed := 0.0

func _ready() -> void:
	if ResourceLoader.exists(video_path):
		video.stream = load(video_path)
		video.finished.connect(_go_next)
		video.play()
	if not video_has_audio:
		soundtrack.play()
		if video.stream == null:
			soundtrack.finished.connect(_go_next)

func _process(delta: float) -> void:
	elapsed = video.stream_position if video.is_playing() else elapsed + delta

	while next_cue < cues.size() and elapsed >= cues[next_cue][0]:
		get_node(cues[next_cue][1]).play()
		next_cue += 1

	if Input.is_action_pressed("ui_accept"):
		hold_time += delta
		if hold_time >= 0.9:
			_go_next()
	else:
		hold_time = 0.0

func _go_next() -> void:
	if leaving:
		return
	leaving = true
	soundtrack.stop()
	video.stop()
	if next_scene != "":
		get_tree().change_scene_to_file(next_scene)
