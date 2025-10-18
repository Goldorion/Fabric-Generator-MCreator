<#if field$dimension??><#--Here for legacy reasons as field$dimension does not exist in older workspaces-->
<@head>if (${input$entity} instanceof ServerPlayer _player && _player.level() instanceof ServerLevel _serverLevel) {</@head>
	ResourceKey<Level> destinationType${cbi} = ${generator.map(field$dimension, "dimensions")};

	if (_player.level().dimension() == destinationType${cbi}) return;

	ServerLevel nextLevel${cbi} = _serverLevel.getServer().getLevel(destinationType${cbi});
	if (nextLevel${cbi} != null) {
		_player.connection.send(new ClientboundGameEventPacket(ClientboundGameEventPacket.WIN_GAME, 0));
		_player.teleportTo(nextLevel${cbi}, _player.getX(), _player.getY(), _player.getZ(), Set.of(), _player.getYRot(), _player.getXRot(), true);
		_player.connection.send(new ClientboundPlayerAbilitiesPacket(_player.getAbilities()));
		for (MobEffectInstance _effectinstance : _player.getActiveEffects())
			_player.connection.send(new ClientboundUpdateMobEffectPacket(_player.getId(), _effectinstance, false));
		_player.connection.send(new ClientboundLevelEventPacket(1032, BlockPos.ZERO, 0, false));
	}
<@tail>}</@tail>
</#if>