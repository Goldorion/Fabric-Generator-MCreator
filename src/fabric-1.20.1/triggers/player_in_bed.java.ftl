<#include "procedures.java.ftl">
public ${name}Procedure() {
	EntitySleepEvents.STOP_SLEEPING.register((entity, blockPos) -> {
		<#assign dependenciesCode><#compress>
			<@procedureDependenciesCode dependencies, {
			"x": "blockPos.getX()",
			"y": "blockPos.getY()",
			"z": "blockPos.getZ()",
			"world": "entity.level()",
			"entity": "entity"
			}/>
		</#compress></#assign>
		execute(${dependenciesCode});
	});
}