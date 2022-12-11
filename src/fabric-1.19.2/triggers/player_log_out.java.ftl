public ${name}Procedure() {
	ServerPlayConnectionEvents.DISCONNECT.register((handler, server) -> {
		Map<String, Object> dependencies = new HashMap<>();
		dependencies.put("entity", Minecraft.getInstance().player);
		dependencies.put("x", Minecraft.getInstance().player.getX());
		dependencies.put("y", Minecraft.getInstance().player.getY());
		dependencies.put("z", Minecraft.getInstance().player.getZ());
		dependencies.put("world", Minecraft.getInstance().player.level);
		execute(dependencies);
	});
}