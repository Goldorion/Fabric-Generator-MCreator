((${input$entity} instanceof ServerPlayer _player && !_player.getLevel().isClientSide()) ?
((_player.getRespawnDimension().equals(_player.getLevel().dimension()) && _player.getRespawnPosition() != null) ?
_player.getRespawnPosition().getZ() : _player.getLevel().getLevelData().getZSpawn()) : 0)