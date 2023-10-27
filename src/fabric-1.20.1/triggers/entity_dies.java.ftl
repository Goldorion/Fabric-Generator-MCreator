<#include "procedures.java.ftl">
public ${name}Procedure() {
	ServerLivingEntityEvents.ALLOW_DEATH.register((entity, damageSource, amount) -> {
		if (entity!=null) {
			<#assign dependenciesCode><#compress>
			<@procedureDependenciesCode dependencies, {
				"x": "entity.getX()",
				"y": "entity.getY()",
				"z": "entity.getZ()",
				"world": "entity.level()",
				"entity": "entity",
				"damagesource": "damageSource",
				"sourceentity": "damageSource.getEntity()",
				}/>
			</#compress></#assign>
			execute(${dependenciesCode});
		}
		return true;
	});
}