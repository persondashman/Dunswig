extends Control



@onready var players := {
	"1": {
		viewport = $"GridContainer/SubViewportContainer/SubViewport",
		camera = $"GridContainer/SubViewportContainer/SubViewport/Camera2D",
		player = $GridContainer/SubViewportContainer/SubViewport/TestLevel/Player,
	},
	"2": {
		viewport = $"GridContainer/SubViewportContainer2/SubViewport",
		camera = $"GridContainer/SubViewportContainer2/SubViewport/Camera2D",
		player = $GridContainer/SubViewportContainer/SubViewport/TestLevel/Player2,
	}
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	players["2"].viewport.world_2d = players["1"].viewport.world_2d
#	players["1"].player.position = Vector2(-66, 72)
	#players["1"].player.controls = load("res://Character/player_1_controls.tres")
#	$HBoxContainer/SubViewport1/Player1/TestLevel.add_child(players["1"]["player"])
	#players["2"].player.position = Vector2(-66, 72)
	#players["2"].player.controls = load("res://Character/player_2_controls.tres")
	#$HBoxContainer/SubViewport1/Player1/TestLevel.add_child(players["2"]["player"])
	for node in players.values():
		var remote_transform := RemoteTransform2D.new()
		remote_transform.remote_path = node.camera.get_path()
		node.player.add_child(remote_transform)
