public ${name}Procedure() {
	UseBlockCallback.EVENT.register((player, level, hand, hitResult) -> {
		Map<String, Object> dependencies = new HashMap<>();
		dependencies.put("world", level);
		dependencies.put("entity", player);
		dependencies.put("x", hitResult.getBlockPos().getX());
		dependencies.put("y", hitResult.getBlockPos().getY());
		dependencies.put("z", hitResult.getBlockPos().getZ());
		dependencies.put("blockstate", level.getBlockState(hitResult.getBlockPos()));
		dependencies.put("direction", hitResult.getDirection());
		execute(dependencies);
		return InteractionResult.PASS;
	});
}