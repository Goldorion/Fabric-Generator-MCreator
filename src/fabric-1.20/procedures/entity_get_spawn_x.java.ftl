((${input$entity} instanceof ServerPlayer _player && !_player.getLevel().isClientSide()) ?
((_player.getRespawnDimension().equals(_player.getLevel().dimension()) && _player.getRespawnPosition() != null) ?
_player.getRespawnPosition().getX() : _player.getLevel().getLevelData().getXSpawn()) : 0)