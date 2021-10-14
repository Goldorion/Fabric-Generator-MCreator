public ${name}Procedure() {
	UseEntityCallback.EVENT.register((player, world, hand, entity, hitResult) -> {
		Map<String, Object> dependencies = new HashMap<>();
		dependencies.put("world", world);
		dependencies.put("sourceentity", player);
		dependencies.put("entity", entity);
		dependencies.put("x", player.getX());
		dependencies.put("y", player.getY());
		dependencies.put("z", player.getZ());
		execute(dependencies);
		return ActionResult.PASS;
	});
}
