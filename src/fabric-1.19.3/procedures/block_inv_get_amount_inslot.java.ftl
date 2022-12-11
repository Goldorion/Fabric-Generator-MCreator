(new Object() {
	public int getAmount(LevelAccessor world, BlockPos pos, int slotid) {
		AtomicInteger count = new AtomicInteger(0);
		BlockEntity _ent = world.getBlockEntity(pos);
		RandomizableContainerBlockEntity ent = (RandomizableContainerBlockEntity) _ent;
		if (_ent != null)
		count.set((int)ent.countItem(ent.getItem(slotid).getItem()));
		return count.get();
	}
}.getAmount(world, (new BlockPos(${input$x}, ${input$y}, ${input$z})), ${opt.toInt(input$slotid)}))