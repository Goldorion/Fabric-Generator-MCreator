<#include "procedures.java.ftl">
public ${name}Procedure() {
	ServerPlayerEvents.AFTER_RESPAWN.register((oldPlayer, newPlayer, alive) -> {
		<#assign dependenciesCode><#compress>
			<@procedureDependenciesCode dependencies, {
			"x": "newPlayer.getX()",
			"y": "newPlayer.getY()",
			"z": "newPlayer.getZ()",
			"world": "newPlayer.level()",
			"entity": "newPlayer"
			}/>
		</#compress></#assign>
		execute(${dependenciesCode});
	});
}