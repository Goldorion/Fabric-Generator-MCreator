<#include "procedures.java.ftl">
public ${name}Procedure() {
	ClientEntityEvents.ENTITY_LOAD.register((entity, world) -> {
		<#assign dependenciesCode>
			<@procedureDependenciesCode dependencies, {
				"x": "entity.getX()",
				"y": "entity.getY()",
				"z": "entity.getZ()",
				"world": "world",
				"entity": "entity"
			}/>
		</#assign>
		execute(${dependenciesCode});
	});
	ServerEntityEvents.ENTITY_LOAD.register((entity, world) -> {
		<#assign dependenciesCode>
			<@procedureDependenciesCode dependencies, {
				"x": "entity.getX()",
				"y": "entity.getY()",
				"z": "entity.getZ()",
				"world": "world",
				"entity": "entity"
			}/>
		</#assign>
		execute(${dependenciesCode});
	});
}