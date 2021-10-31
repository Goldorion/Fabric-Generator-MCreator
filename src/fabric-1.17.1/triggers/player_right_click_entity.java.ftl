public ${name}Procedure() {
	UseEntityCallback.EVENT.register((player, level, hand, entity, hitResult) -> {
		Map<String, Object> dependencies = new HashMap<>();
		dependencies.put("world", level);
		dependencies.put("sourceentity", player);
		dependencies.put("entity", entity);
		dependencies.put("x", player.getX());
		dependencies.put("y", player.getY());
		dependencies.put("z", player.getZ());
		execute(dependencies);
		return InteractionResult.PASS;
	});
}
