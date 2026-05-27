<#include "procedures.java.ftl">
public ${name}Procedure() {
	ServerLivingEntityEvents.ALLOW_DAMAGE.register((entity, damageSource, amount) -> {
		if (entity != null) {
			<#assign dependenciesCode>
			<@procedureDependenciesCode dependencies, {
				"x": "entity.getX()",
				"y": "entity.getY()",
				"z": "entity.getZ()",
				"world": "entity.level()",
				"amount": "amount",
				"entity": "entity",
				"damagesource": "damageSource",
				"sourceentity": "damageSource.getEntity()"
				}/>
			</#assign>
			execute(${dependenciesCode});
		}
		boolean result = eventResult;
    	eventResult = true;
    	return result;
	});
}