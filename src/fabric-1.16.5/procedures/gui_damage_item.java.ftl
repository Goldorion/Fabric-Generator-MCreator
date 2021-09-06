if(${input$entity} instanceof ServerPlayerEntity) {
	ScreenHandler _current = ((ServerPlayerEntity) ${input$entity}).currentScreenHandler;
	if(_current instanceof Supplier) {
		Object invobj = ((Supplier) _current).get();
		if(invobj instanceof Map) {
			ItemStack stack=((Slot) ((Map) invobj).get((int)(${input$slotid}))).getStack();
    		if(stack != null) {
			    if (stack.damage((int) 1, new Random(), null)) {
				    stack.decrement(1);
					stack.setDamage(0);
				}
				_current.sendContentUpdates();
    		}
		}
	}
}