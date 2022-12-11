public ${name}Procedure() {
	ServerLivingEntityEvents.ALLOW_DAMAGE.register((entity, damageSource, amount) -> {
		Map<String, Object> dependencies = new HashMap<>();
		dependencies.put("entity", entity);
		dependencies.put("x", entity.getX());
		dependencies.put("y", entity.getY());
		dependencies.put("z", entity.getZ());
		dependencies.put("world", entity.level);
		dependencies.put("sourceentity", damageSource.getEntity());
		dependencies.put("immediatesourceentity", damageSource.getDirectEntity());
		dependencies.put("amount", amount);
		execute(dependencies);
		return true;
	});
}
