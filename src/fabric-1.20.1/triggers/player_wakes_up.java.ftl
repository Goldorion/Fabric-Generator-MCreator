<#include "procedures.java.ftl">
public ${name}Procedure() {
	EntitySleepEvents.STOP_SLEEPING.register((entity, blockPos) -> {
		<#assign dependenciesCode><#compress>
			<@procedureDependenciesCode dependencies, {
			"x": "entity.getX()",
			"y": "entity.getY()",
			"z": "entity.getZ()",
			"world": "entity.level()",
			"entity": "entity"
			}/>
		</#compress></#assign>
		execute(${dependenciesCode});
	});
}