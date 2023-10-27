<#include "procedures.java.ftl">
public ${name}Procedure() {
	ServerLivingEntityEvents.ALLOW_DAMAGE.register((entity, damageSource, amount) -> {
		if (entity!=null) {
			<#assign dependenciesCode><#compress>
			<@procedureDependenciesCode dependencies, {
				"x": "entity.getX()",
				"y": "entity.getY()",
				"z": "entity.getZ()",
				"amount": "amount",
				"world": "entity.level()",
				"entity": "entity",
				"damagesource": "damageSource",
				"sourceentity": "damageSource.getEntity())",
				"immediatesourceentity": "damageSource.getDirectEntity()"
				}/>
			</#compress></#assign>
			execute(${dependenciesCode});
		}
		return true;
	});
}
