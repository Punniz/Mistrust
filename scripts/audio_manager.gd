extends Node
class_name AudioManager


@onready var ambient_track: AudioStreamPlayer = $AmbientTrack
@onready var music_track: AudioStreamPlayer = $MusicTrack


func _ready() -> void:
	Events.player_caught.connect(on_player_caught)
	Events.game_over.connect(on_game_over)


func on_player_caught() -> void:
	music_track.stop()


func on_game_over() -> void:
	ambient_track.stop()
