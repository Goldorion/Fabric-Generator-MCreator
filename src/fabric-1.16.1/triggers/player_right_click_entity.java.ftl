@Override
public void useOnEntity(PlayerEntity player, World world, Hand hand, Entity entity, /* Nullable */ EntityHitResult hitResult){
		Map<String, Object> dependencies = new HashMap<>();
		int i=player.getX();
		int j=player.getY();
		int k=player.getZ();
		dependencies.put("world",world);
		dependencies.put("sourceentity" ,player);
		dependencies.put("entity", entity);
		dependencies.put("x" ,i);
		dependencies.put("y" ,j);
		dependencies.put("z" ,k);
		executeProcedure(dependencies);
}