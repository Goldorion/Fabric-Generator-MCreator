<#include "mcitems.ftl">
<#include "mcelements.ftl">
<@head>if (${input$entity} instanceof LivingEntity _living) {</@head>
	_living.setItemSlot(${toArmorSlot(input$slotid)}, ${mappedMCItemToItemStackCode(input$item, 1)});
<@tail>}</@tail>