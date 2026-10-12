public ${name}Procedure() {
	if (FabricLoader.getInstance().getEnvironmentType() == EnvType.CLIENT)
		ClientLifecycleEvents.CLIENT_STARTED.register((client) -> {
			execute();
		});
}