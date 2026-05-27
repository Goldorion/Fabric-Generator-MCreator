<#include "procedures.java.ftl">
public ${name}Procedure() {
	PlayerEvents.END_PLAYER_TICK.register(entity -> {
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