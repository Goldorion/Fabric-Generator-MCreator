public ${name}Procedure() {
	ServerTickEvents.END_WORLD_TICK.register((level) -> {
		Map<String, Object> dependencies = new HashMap<>();
		dependencies.put("world", level);
		execute(dependencies);
	});
}
