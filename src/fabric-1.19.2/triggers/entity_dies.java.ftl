public ${name}Procedure() {
		ServerEntityCombatEvents.AFTER_KILLED_OTHER_ENTITY.register((level, sourceentity, entity) -> {
			Map<String, Object> dependencies = new HashMap<>();
			dependencies.put("entity", entity);
			dependencies.put("x", entity.getX());
			dependencies.put("y", entity.getY());
			dependencies.put("z", entity.getZ());
			dependencies.put("world", level);
			dependencies.put("sourceentity", sourceentity);
			execute(dependencies);
	});
}