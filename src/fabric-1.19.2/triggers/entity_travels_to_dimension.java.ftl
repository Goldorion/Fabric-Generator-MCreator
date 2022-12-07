public ${name}Procedure() {
	ServerEntityWorldChangeEvents.AFTER_ENTITY_CHANGE_WORLD.register((originalEntity, newEntity, origin, destination) -> {
		Map<String, Object> dependencies = new HashMap<>();
		dependencies.put("x", newEntity.getX());
		dependencies.put("y", newEntity.getY());
		dependencies.put("z", newEntity.getZ());
		dependencies.put("world", destination);
		dependencies.put("entity", newEntity);
		dependencies.put("dimension", destination.dimension());
		if (!(newEntity instanceof Player))
			execute(dependencies);
	});
	ServerEntityWorldChangeEvents.AFTER_PLAYER_CHANGE_WORLD.register((player, origin, destination) -> {
		Map<String, Object> dependencies = new HashMap<>();
		dependencies.put("x", player.getX());
		dependencies.put("y", player.getY());
		dependencies.put("z", player.getZ());
		dependencies.put("world", destination);
		dependencies.put("entity", player);
		dependencies.put("dimension", destination.dimension());
		execute(dependencies);
	});
}
