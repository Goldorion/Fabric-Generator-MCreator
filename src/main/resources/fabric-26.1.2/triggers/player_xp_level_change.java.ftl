<#include "procedures.java.ftl">
public ${name}Procedure() {
	PlayerEvents.LEVEL_CHANGE.register((entity, amount) -> {
		<#assign dependenciesCode>
			<@procedureDependenciesCode dependencies, {
			"x": "entity.getX()",
			"y": "entity.getY()",
			"z": "entity.getZ()",
			"amount": "amount",
			"world": "entity.level()",
			"entity": "entity"
			}/>
		</#assign>
		execute(${dependenciesCode});
	});
}