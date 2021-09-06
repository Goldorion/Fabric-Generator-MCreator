<#include "mcitems.ftl">
if(${input$entity} instanceof PlayerEntity) {
	ScreenHandler _current = ((PlayerEntity) ${input$entity}).currentScreenHandler;
	if(_current instanceof Supplier) {
		Object invobj = ((Supplier) _current).get();
		if(invobj instanceof Map) {
			ItemStack _setstack = ${mappedMCItemToItemStackCode(input$item, 1)};
			_setstack.setCount((int) ${input$amount});
			((Slot) ((Map) invobj).get((int)(${input$slotid}))).setStack(_setstack);
			_current.sendContentUpdates();
		}
	}
}