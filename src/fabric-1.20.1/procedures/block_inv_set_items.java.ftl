<#include "mcelements.ftl">
<#include "mcitems.ftl">
{
	BlockEntity _ent = world.getBlockEntity(${toBlockPos(input$x,input$y,input$z)});
	ItemStack stack = ${mappedMCItemToItemStackCode(input$item, 1)};
	stack.setCount(${opt.toInt(input$amount)});
	if (_ent != null) {
		((RandomizableContainerBlockEntity) _ent).setItem(${opt.toInt(input$slotid)}, stack);
	}
}