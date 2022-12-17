public ${name}Procedure() {
	EntitySleepEvents.STOP_SLEEPING.register((entity, blockPos) -> {
		Map<String, Object> dependencies = new HashMap<>();
		dependencies.put("world", entity.level);
		dependencies.put("entity", entity);
		dependencies.put("x", entity.getX());
		dependencies.put("y", entity.getY());
		dependencies.put("z", entity.getZ());
		execute(dependencies);
	});
}