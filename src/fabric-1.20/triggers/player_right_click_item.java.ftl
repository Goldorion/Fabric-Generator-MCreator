public ${name}Procedure() {
	UseItemCallback.EVENT.register((player, level, hand) -> {
		Map<String, Object> dependencies = new HashMap<>();
		dependencies.put("world", level);
		dependencies.put("entity", player);
		dependencies.put("x", player.getX());
		dependencies.put("y", player.getY());
		dependencies.put("z", player.getZ());
		execute(dependencies);
		return InteractionResultHolder.pass(player.getItemInHand(hand));
	});
}
