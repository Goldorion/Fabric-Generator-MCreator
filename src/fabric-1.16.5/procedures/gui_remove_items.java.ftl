{
	Entity _ent = ${input$entity};
	if(_ent instanceof ServerPlayerEntity) {
		ScreenHandler _current = ((ServerPlayerEntity) _ent).currentScreenHandler;
		if(_current instanceof Supplier) {
			Object invobj = ((Supplier) _current).get();
			if(invobj instanceof Map) {
				((Slot) ((Map) invobj).get((int)(${input$slotid}))).takeStack((int)(${input$amount}));
				_current.sendContentUpdates();
			}
		}
	}
}