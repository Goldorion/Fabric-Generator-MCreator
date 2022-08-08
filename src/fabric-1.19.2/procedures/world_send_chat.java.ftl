if (!world.isClientSide()) {
	MinecraftServer _mcserv = ServerLifecycleHooks.getCurrentServer();
	if (_mcserv != null)
		_mcserv.getPlayerList().broadcastMessage(Component.literal(${input$text}), ChatType.SYSTEM, Util.NIL_UUID);
}