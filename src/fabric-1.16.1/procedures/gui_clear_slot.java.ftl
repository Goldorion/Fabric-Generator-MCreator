if(${input$entity} instanceof ServerPlayerEntity) {
	ScreenHandler _current = ((ServerPlayerEntity) ${input$entity}).currentScreenHandler;
	if(_current instanceof Supplier) {
		Object invobj = ((Supplier) _current).get();
		if(invobj instanceof Map) {
			((Slot) ((Map) invobj).get((int) (${input$slotid}))).setStack(ItemStack.EMPTY);
			_current.sendContentUpdates();
		}
	}
}