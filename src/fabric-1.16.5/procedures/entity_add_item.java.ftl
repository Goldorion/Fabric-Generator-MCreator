<#include "mcitems.ftl">
if(${input$entity} instanceof PlayerEntity) {
	ItemStack _setstack = ${mappedMCItemToItemStackCode(input$item, 1)};
	_setstack.setCount((int) ${input$amount});
	if(${input$entity}.world.isClient()) {
		if(((PlayerEntity) ${input$entity}).inventory.getEmptySlot() != -1) {
			((PlayerEntity) ${input$entity}).inventory.main.add(((PlayerEntity) ${input$entity}).inventory.getEmptySlot(), _setstack);
			((PlayerEntity) ${input$entity}).inventory.markDirty();
		}
	}
}
