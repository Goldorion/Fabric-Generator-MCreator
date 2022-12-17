public ${name}Procedure() {
	ServerPlayConnectionEvents.JOIN.register((handler, sender, server) -> {
		Map<String, Object> dependencies = new HashMap<>();
		dependencies.put("entity", handler.getPlayer());
		dependencies.put("x", handler.getPlayer().getX());
		dependencies.put("y", handler.getPlayer().getY());
		dependencies.put("z", handler.getPlayer().getZ());
		dependencies.put("world", handler.getPlayer().getLevel());
		execute(dependencies);
	});
}