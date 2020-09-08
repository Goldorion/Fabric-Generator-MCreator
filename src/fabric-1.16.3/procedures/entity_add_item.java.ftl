<#include "mcitems.ftl">
if(${input$entity} instanceof PlayerEntity) {
	ItemStack _setstack = ${mappedMCItemToItemStackCode(input$item, 1)};
	_setstack.setCount((int) ${input$amount});
	if(${input$entity}.world.isClient()) {
		if(${input$entity}.inventory.getEmptySlot() != -1) {
			${input$entity}.inventory.main.add(${input$entity}.inventory.getEmptySlot(), _setstack);
			${input$entity}.inventory.markDirty();
		}
	}
}
