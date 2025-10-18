<#include "mcitems.ftl">
<@head>if (world instanceof ServerLevel _level) {</@head>
	ItemEntity entityToSpawn_${cbi} = new ItemEntity(_level, ${input$x}, ${input$y}, ${input$z}, ${mappedMCItemToItemStackCode(input$block, 1)});
	entityToSpawn_${cbi}.setPickUpDelay(${opt.toInt(input$pickUpDelay!10)});
	<#if (field$despawn!"TRUE") == "FALSE">
	entityToSpawn_${cbi}.setUnlimitedLifetime();
	</#if>
	_level.addFreshEntity(entityToSpawn_${cbi});
<@tail>}</@tail>