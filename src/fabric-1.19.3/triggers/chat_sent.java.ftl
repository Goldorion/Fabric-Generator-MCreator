public ${name}Procedure() {
	ServerMessageEvents.CHAT_MESSAGE.register((message, sender, params) -> {
		Map<String, Object> dependencies = new HashMap<>();
		dependencies.put("entity", sender);
		dependencies.put("x", sender.getX());
		dependencies.put("y", sender.getY());
		dependencies.put("z", sender.getZ());
		dependencies.put("world", sender.level);
		dependencies.put("text", message);
		execute(dependencies);
	});
}