((${input$entity} instanceof ServerPlayer _player && !_player.getLevel().isClientSide()) ?
((_player.getRespawnDimension().equals(_player.getLevel().dimension()) && _player.getRespawnPosition() != null) ?
_player.getRespawnPosition().getY() : _player.getLevel().getLevelData().getYSpawn()) : 0)