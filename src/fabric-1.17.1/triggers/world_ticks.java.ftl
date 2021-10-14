public ${name}Procedure() {
	ServerTickEvents.END_WORLD_TICK.register((world) -> {
		Map<String, Object> dependencies = new HashMap<>();
		dependencies.put("world",world);
		execute(dependencies);
	});
}
