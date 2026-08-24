extends TileMapLayer

func _ready() -> void:
	FootStepSoundManager.register_tilemap(self)


func _exit_tree() -> void:
	FootStepSoundManager.unregister_tilemap(self)
