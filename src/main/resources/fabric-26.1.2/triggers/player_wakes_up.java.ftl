<#include "procedures.java.ftl">
public ${name}Procedure() {
	EntitySleepEvents.STOP_SLEEPING.register((entity, blockPos) -> {
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