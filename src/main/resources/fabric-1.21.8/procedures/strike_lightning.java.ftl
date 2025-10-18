<#include "mcelements.ftl">
<@head>if (world instanceof ServerLevel _level) {</@head>
	LightningBolt entityToSpawn_${cbi} = EntityType.LIGHTNING_BOLT.create(_level, EntitySpawnReason.TRIGGERED);
	entityToSpawn_${cbi}.snapTo(Vec3.atBottomCenterOf(${toBlockPos(input$x,input$y,input$z)}));
	<#if (field$effectOnly!"FALSE") == "TRUE">entityToSpawn_${cbi}.setVisualOnly(true)</#if>;
	_level.addFreshEntity(entityToSpawn_${cbi});
<@tail>}</@tail>