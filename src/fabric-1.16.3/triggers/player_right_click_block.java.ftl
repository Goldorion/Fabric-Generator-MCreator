public ${name}Procedure() {
	UseBlockCallback.EVENT.register((player, world, hand, hitResult) -> {
		Map<String, Object> dependencies = new HashMap<>();
		int i=(int) player.getX();
		int j=(int) player.getY();
		int k=(int) player.getZ();
		dependencies.put("world",world);
		dependencies.put("entity" ,player);
		dependencies.put("x" ,i);
		dependencies.put("y" ,j);
		dependencies.put("z" ,k);
		executeProcedure(dependencies);
		return ActionResult.PASS;
	});
}