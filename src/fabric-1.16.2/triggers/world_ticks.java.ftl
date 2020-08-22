public ${name}Procedure() {
	WorldTickCallback.EVENT.register((world) -> {
		Map<String, Object> dependencies = new HashMap<>();
		dependencies.put("world",world);
		executeProcedure(dependencies);
	});
}
