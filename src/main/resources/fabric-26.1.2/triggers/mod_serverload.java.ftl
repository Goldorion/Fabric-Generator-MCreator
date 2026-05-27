public ${name}Procedure() {
	ServerLifecycleEvents.SERVER_STARTING.register((client) -> {
		execute();
	});
}