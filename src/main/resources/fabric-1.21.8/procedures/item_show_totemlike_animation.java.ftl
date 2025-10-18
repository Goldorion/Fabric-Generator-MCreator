<#include "mcitems.ftl">
<@head>if(world.isClientSide()) {</@head>
	Minecraft.getInstance().gameRenderer.displayItemActivation(${mappedMCItemToItemStackCode(input$item, 1)});
<@tail>}</@tail>