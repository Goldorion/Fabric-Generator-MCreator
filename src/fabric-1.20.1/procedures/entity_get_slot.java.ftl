/*@ItemStack*/(new Object(){
	public ItemStack getItemStack(int slotid, Entity entity) {
		AtomicReference<ItemStack> stack = new AtomicReference<>(ItemStack.EMPTY);
			stack.set(${input$entity}.getSlot(${input$slotid}).get().copy());
		return stack.get();
	}
}.getItemStack(${opt.toInt(input$slotid)}, ${input$entity}))