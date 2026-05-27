<#include "procedures.java.ftl">
<#include "procedures.java.ftl">
public ${name}Procedure() {
	LivingEntityEvents.START_USE_ITEM.register((entity, itemstack) -> {
		<#assign dependenciesCode>
			<@procedureDependenciesCode dependencies, {
			"x": "entity.getX()",
			"y": "entity.getY()",
			"z": "entity.getZ()",
			"itemstack": "itemstack",
			"duration": "itemstack.getUseDuration((LivingEntity) entity)",
			"world": "entity.level()",
			"entity": "entity"
			}/>
		</#assign>
		execute(${dependenciesCode});
	});
}