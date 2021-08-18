<#include "mcitems.ftl">
{
	ItemStack _ist = ${mappedMCItemToItemStackCode(input$item, 1)};
	if(_ist.damage((int) ${input$amount},new Random(),null)) {
        _ist.decrement(1);
        _ist.setDamage(0);
    }
}