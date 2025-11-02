<#include "procedures.java.ftl">
public ${name}Procedure() {
	LivingEntityEvents.ENTITY_PICKUP_ITEM.register((entity, itemstack) -> {
		<#assign dependenciesCode>
			<@procedureDependenciesCode dependencies, {
				"x": "entity.getX()",
				"y": "entity.getY()",
				"z": "entity.getZ()",
				"world": "entity.level()",
				"entity": "entity",
				"itemstack": "itemstack"
			}/>
		</#assign>
		execute(${dependenciesCode});
	});
}