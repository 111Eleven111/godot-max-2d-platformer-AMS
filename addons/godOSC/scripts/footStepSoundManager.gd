extends Node 

var tilemaps: Array[TileMapLayer] = []
var footstep_player: AudioStreamPlayer
var debug_tile_checks := true
@export_range(1, 30) var cooldown_frames := 5
var cooldown_counter := 0

@onready var osc_client: Object = preload("res://addons/godOSC/scripts/OSCClient.gd").new()

const footstep_sounds = {
	"cloud": [
		preload("res://sfx/cloud/cloud-walk-1.mp3"),
		preload("res://sfx/cloud/cloud-walk-2.mp3"),
		preload("res://sfx/cloud/cloud-walk-3.mp3")
		]
}

func _ready() -> void:
	footstep_player = AudioStreamPlayer.new()
	add_child(footstep_player)

func _physics_process(_delta: float) -> void:
	if cooldown_counter > 0:
		cooldown_counter -= 1

func play_footstep(position: Vector2):
	if cooldown_counter > 0:
		if debug_tile_checks:
			print("[Footstep] cooldown active:", cooldown_counter)
		return

	if debug_tile_checks:
		print("[Footstep] checking world position:", position)

	var probe_offsets = [
		Vector2.ZERO,
		Vector2(0, 6),
		Vector2(0, 12),
		Vector2(-4, 8),
		Vector2(4, 8)
	]

	for tilemap in tilemaps:
		for probe in probe_offsets:
			var probe_world = position + probe
			var local_pos = tilemap.to_local(probe_world)
			var tile_position = tilemap.local_to_map(local_pos)
			var data = tilemap.get_cell_tile_data(tile_position)
			var cloud_tag = "<no data>"

			if data:
				cloud_tag = str(data.get_custom_data("cloud"))

			if debug_tile_checks:
				print("[Footstep] tilemap=", tilemap.name, " probe=", probe, " local=", local_pos, " cell=", tile_position, " cloud=", cloud_tag)

			# play cloud footstep if the tile has the "cloud" custom data
			if data and data.get_custom_data("cloud") == "cloud":

				if debug_tile_checks:
					print("[Footstep] cloud step matched on ", tilemap.name, " at cell ", tile_position)

				# audiostream player method:
				# footstep_player.stream = footstep_sounds["cloud"].pick_random()
				# footstep_player.play()
				# cooldown_counter = cooldown_frames

				# instead, use MAX
				osc_client.send_message("/player/footstep/cloud", [1])

				if debug_tile_checks:
					print("[Footstep] sent OSC message for cloud step")
				return

	if debug_tile_checks:
		print("[Footstep] no cloud tile matched for this step")
		
