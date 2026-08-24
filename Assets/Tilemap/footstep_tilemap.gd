extends TileMapLayer

func _ready() -> void:
	FootStepSoundManager.tilemaps.push_back(self)
