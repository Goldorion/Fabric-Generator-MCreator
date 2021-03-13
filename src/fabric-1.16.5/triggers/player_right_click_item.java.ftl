public ${name}Procedure() {
	UseItemCallback.EVENT.register((player, world, hand) -> {
		Map<String, Object> dependencies = new HashMap<>();
		double i=(int) player.getX();
		double j=(int) player.getY();
		double k=(int) player.getZ();
		dependencies.put("world", world);
		dependencies.put("entity", player);
		dependencies.put("x", i);
		dependencies.put("y", j);
		dependencies.put("z", k);
		executeProcedure(dependencies);
		return TypedActionResult.pass(player.getStackInHand(hand));
	});
}
