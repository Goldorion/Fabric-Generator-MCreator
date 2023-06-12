public ${name}Procedure() {
	AttackBlockCallback.EVENT.register((player, level, hand, pos, direction) -> {
		Map<String, Object> dependencies = new HashMap<>();
		dependencies.put("world", level);
		dependencies.put("entity", player);
		dependencies.put("x", pos.getX());
		dependencies.put("y", pos.getY());
		dependencies.put("z", pos.getZ());
		dependencies.put("blockstate", level.getBlockState(pos));
		dependencies.put("direction", direction);
		execute(dependencies);
		return InteractionResult.PASS;
	});
}