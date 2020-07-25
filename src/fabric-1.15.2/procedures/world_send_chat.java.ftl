{
	if(world instanceof ServerWorld) {
		MinecraftServer mcserv = ((ServerWorld) world).getServer();
		mcserv.getPlayerManager().getPlayerList().forEach((player) -> {
			player.sendMessage(new LiteralText(${input$text}), false);
		});
	}
}