/*@ItemStack*/(${input$entity} instanceof ServerPlayer _plrSlotItem ? _plrSlotItem.containerMenu.getSlot(${opt.toInt(input$slotid)}).getItem() : ItemStack.EMPTY)
	