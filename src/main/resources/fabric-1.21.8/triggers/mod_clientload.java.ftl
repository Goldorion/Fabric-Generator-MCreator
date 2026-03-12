public ${name}Procedure() {
	ClientLifecycleEvents.CLIENT_STARTED.register((client) -> {
		execute();
	});
}