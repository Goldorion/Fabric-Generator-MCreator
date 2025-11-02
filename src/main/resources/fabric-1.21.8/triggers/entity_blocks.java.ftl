<#include "procedures.java.ftl">
public ${name}Procedure() {
	LivingEntityEvents.ENTITY_BLOCK.register((entity, damagesource, amount) -> {
		if (entity != null) {
			<#assign dependenciesCode>
			<@procedureDependenciesCode dependencies, {
				"x": "entity.getX()",
				"y": "entity.getY()",
				"z": "entity.getZ()",
				"world": "entity.level()",
				"entity": "entity",
				"damagesource": "damagesource",
				"sourceentity": "damagesource.getEntity()",
				"immediatesourceentity": "damagesource.getDirectEntity()",
				"originalblockedamount": "amount",
				"blockedamount": "amount"
				}/>
			</#assign>
			execute(${dependenciesCode});
		}
		boolean result = eventResult;
		eventResult = true;
		return result;
	});
}