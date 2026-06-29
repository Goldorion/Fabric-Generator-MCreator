<#include "procedures.java.ftl">
public ${name}Procedure() {
	LivingEntityEvents.END_ENTITY_TICK.register(entity -> {
		<#assign dependenciesCode>
			<@procedureDependenciesCode dependencies, {
				"x": "entity.getX()",
				"y": "entity.getY()",
				"z": "entity.getZ()",
				"world": "entity.level()",
				"entity": "entity"
			}/>
		</#assign>
		execute(${dependenciesCode});
	});
}