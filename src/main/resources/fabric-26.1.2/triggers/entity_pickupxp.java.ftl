<#include "procedures.java.ftl">
public ${name}Procedure() {
	PlayerEvents.PICKUP_XP.register((entity) -> {
		if (entity != null) {
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
		}
		boolean result = eventResult;
    	eventResult = true;
    	return result;
	});
}