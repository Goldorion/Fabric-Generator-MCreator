((${input$entity} instanceof ServerPlayer _player) ?
	(_player.getRespawnConfig() != null && (_player.getRespawnConfig().respawnData().dimension().equals(_player.level().dimension())) ?
		_player.getRespawnConfig().respawnData().pos().getX() : _player.level().getLevelData().getRespawnData().pos().getX()) : 0)