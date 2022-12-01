{
	ItemStack stack = new ItemStack(${input$slotitem});
	stack.setCount(${opt.toInt(input$amount)});
	${input$entity}.getSlot(${opt.toInt(input$slotid)}).set(stack);
}
