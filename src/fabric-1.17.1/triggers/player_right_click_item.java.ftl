public ${name}Procedure() {
	UseItemCallback.EVENT.register((player, world, hand) -> {
		Map<String, Object> dependencies = new HashMap<>();
		dependencies.put("world", world);
		dependencies.put("entity", player);
		dependencies.put("x", player.getX());
		dependencies.put("y", player.getY());
		dependencies.put("z", player.getZ());
		execute(dependencies);
		return TypedActionResult.pass(player.getStackInHand(hand));
	});
}
