public ${name}Procedure() {
	ServerPlayerEvents.AFTER_RESPAWN.register((oldPlayer, newPlayer, alive) -> {
		Map<String, Object> dependencies = new HashMap<>();
		dependencies.put("x", newPlayer.getX());
		dependencies.put("y", newPlayer.getY());
		dependencies.put("z", newPlayer.getZ());
		dependencies.put("world", newPlayer.level);
		dependencies.put("entity", newPlayer);
		dependencies.put("oldEntity", oldPlayer);
		execute(dependencies);
	});
}