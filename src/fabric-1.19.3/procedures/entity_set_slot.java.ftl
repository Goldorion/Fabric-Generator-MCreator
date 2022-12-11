<#include "mcitems.ftl">
{
	ItemStack stack = ${mappedMCItemToItemStackCode(input$slotitem, 1)};
	stack.setCount(${opt.toInt(input$amount)});
	${input$entity}.getSlot(${opt.toInt(input$slotid)}).set(stack);
}
