/*@ItemStack*/(new Object(){
	public ItemStack getItemStack(int sltid) {
			Entity _ent = ${input$entity};
			if(_ent instanceof ServerPlayerEntity) {
				ScreenHandler _current = ((ServerPlayerEntity) _ent).currentScreenHandler;
				if(_current instanceof Supplier) {
					Object invobj = ((Supplier) _current).get();
					if(invobj instanceof Map) {
						return ((Slot) ((Map) invobj).get(sltid)).getStack();
					}
				}
			}
			return ItemStack.EMPTY;
		}
	}.getItemStack((int)(${input$slotid})))