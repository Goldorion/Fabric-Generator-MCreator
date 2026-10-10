<#include "procedures.java.ftl">
public ${name}Procedure() {
	ServerEntityLevelChangeEvents.AFTER_ENTITY_CHANGE_LEVEL.register((originalEntity, newEntity, origin, destination) -> {
		<#assign dependenciesCode>
			<@procedureDependenciesCode dependencies, {
			"x": "newEntity.getX()",
			"y": "newEntity.getY()",
			"z": "newEntity.getZ()",
			"world": "destination",
			"dimension": "destination.dimension()",
			"entity": "newEntity"
			}/>
		</#assign>
		if (!(newEntity instanceof Player))
			execute(${dependenciesCode});
	});
	ServerEntityLevelChangeEvents.AFTER_PLAYER_CHANGE_LEVEL.register((player, origin, destination) -> {
		<#assign dependenciesCode>
			<@procedureDependenciesCode dependencies, {
			"x": "player.getX()",
			"y": "player.getY()",
			"z": "player.getZ()",
			"world": "destination",
			"dimension": "destination.dimension()",
			"entity": "player"
			}/>
		</#assign>
		execute(${dependenciesCode});
	});
}
