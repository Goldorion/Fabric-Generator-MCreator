<#include "mcelements.ftl">
<#assign entity = generator.map(field$entity, "entities", 1)!"null">
<#if entity != "null">
<@head>if (world instanceof ServerLevel _level) {</@head>
	Entity entityToSpawn_${cbi} = ${entity}.spawn(_level, ${toBlockPos(input$x,input$y,input$z)}, EntitySpawnReason.MOB_SUMMONED);
	if (entityToSpawn_${cbi} != null) {
		<#if input$yaw != "/*@int*/0">
			entityToSpawn_${cbi}.setYRot(${opt.toFloat(input$yaw)});
			entityToSpawn_${cbi}.setYBodyRot(${opt.toFloat(input$yaw)});
			entityToSpawn_${cbi}.setYHeadRot(${opt.toFloat(input$yaw)});
		</#if>
		<#if input$pitch != "/*@int*/0">
			entityToSpawn_${cbi}.setXRot(${opt.toFloat(input$pitch)});
		</#if>
		entityToSpawn_${cbi}.setDeltaMovement(${input$vx}, ${input$vy}, ${input$vz});
	}
<@tail>}</@tail>
</#if>