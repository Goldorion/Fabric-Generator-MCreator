<#include "mcelements.ftl">
<#assign entity = generator.map(field$entity, "entities", 1)!"null">
<#if entity != "null">
<@head>if (world instanceof ServerLevel _level) {</@head>
	Entity entityToSpawn_${cbi} = ${entity}.spawn(_level, ${toBlockPos(input$x,input$y,input$z)}, EntitySpawnReason.MOB_SUMMONED);
	if (entityToSpawn_${cbi} != null) {
		entityToSpawn_${cbi}.setYRot(world.getRandom().nextFloat() * 360F);
	}
<@tail>}</@tail>
</#if>