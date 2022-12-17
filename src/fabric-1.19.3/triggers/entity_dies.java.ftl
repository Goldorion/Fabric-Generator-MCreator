public ${name}Procedure() {
	ServerLivingEntityEvents.ALLOW_DEATH.register((entity, damageSource, amount) -> {
		Map<String, Object> dependencies = new HashMap<>();
		dependencies.put("entity", entity);
		dependencies.put("x", entity.getX());
		dependencies.put("y", entity.getY());
		dependencies.put("z", entity.getZ());
		dependencies.put("world", entity.level);
		dependencies.put("sourceentity", damageSource.getEntity());
		execute(dependencies);
		return true;
	});
}