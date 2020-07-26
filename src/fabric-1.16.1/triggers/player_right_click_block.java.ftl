@Override
public void useOnBlock(PlayerEntity player, World world, Hand hand, BlockHitResult hitResult){
		Map<String, Object> dependencies = new HashMap<>();
		int i=player.getX();
		int j=player.getY();
		int k=player.getZ();
		dependencies.put("world",world);
		dependencies.put("entity" ,player);
		dependencies.put("x" ,i);
		dependencies.put("y" ,j);
		dependencies.put("z" ,k);
		executeProcedure(dependencies);
}
