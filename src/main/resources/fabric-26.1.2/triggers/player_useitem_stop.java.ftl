<#include "procedures.java.ftl">
public ${name}Procedure() {
	LivingEntityEvents.ENTITY_STOP_USING_ITEM.register((entity, itemstack, duration) -> {
		<#assign dependenciesCode>
			<@procedureDependenciesCode dependencies, {
				"x": "entity.getX()",
				"y": "entity.getY()",
				"z": "entity.getZ()",
				"itemstack": "itemstack",
				"duration": "duration",
				"world": "entity.level()",
				"entity": "entity"
			}/>
		</#assign>
		execute(${dependenciesCode});
	});
}