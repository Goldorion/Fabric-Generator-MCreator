public ${name}Procedure() {
	UseBlockCallback.EVENT.register((player, level, hand, hitResult) -> {
		Map<String, Object> dependencies = new HashMap<>();
		dependencies.put("world",level);
		dependencies.put("entity", player);
		dependencies.put("x", player.getX());
		dependencies.put("y", player.getY());
		dependencies.put("z", player.getZ());
		execute(dependencies);
		return InteractionResult.PASS;
	});
}