public ${name}Procedure() {
	ServerMessageEvents.COMMAND_MESSAGE.register((message, source, params) -> {
		Map<String, Object> dependencies = new HashMap<>();
		dependencies.put("entity", source.getEntity());
		dependencies.put("x", source.getEntity().getX());
		dependencies.put("y", source.getEntity().getY());
		dependencies.put("z", source.getEntity().getZ());
		dependencies.put("world", source.getEntity().level);
		dependencies.put("command", message);
		execute(dependencies);
	});
}