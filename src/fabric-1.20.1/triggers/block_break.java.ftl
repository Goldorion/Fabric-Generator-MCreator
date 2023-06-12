public ${name}Procedure() {
	PlayerBlockBreakEvents.BEFORE.register((world, player, pos, state, blockentity) -> {
		Map<String, Object> dependencies = new HashMap<>();
		dependencies.put("x", pos.getX());
		dependencies.put("y", pos.getY());
		dependencies.put("z", pos.getZ());
		dependencies.put("px", player.getX());
		dependencies.put("py", player.getY());
		dependencies.put("pz", player.getZ());
		dependencies.put("blockstate", state);
		dependencies.put("world", world);
		dependencies.put("entity", player);
		execute(dependencies);
		return true;
	});
}