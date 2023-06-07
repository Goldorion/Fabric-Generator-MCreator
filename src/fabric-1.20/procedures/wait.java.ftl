new Object() {
	private int ticks = 0;

	public void startDelay(LevelAccessor world) {
	ServerTickEvents.END_SERVER_TICK.register((server) -> {
		this.ticks++;
		if (this.ticks == ${opt.toInt(input$ticks)}) {
		${statement$do}
			return;
			}
		});
	}	
}.startDelay(world);
