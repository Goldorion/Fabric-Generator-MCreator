<#include "procedures.java.ftl">
public ${name}Procedure() {
	ServerEntityWorldChangeEvents.AFTER_ENTITY_CHANGE_WORLD.register((originalEntity, newEntity, origin, destination) -> {
		<#assign dependenciesCode><#compress>
			<@procedureDependenciesCode dependencies, {
			"x": "newEntity.getX()",
			"y": "newEntity.getY()",
			"z": "newEntity.getZ()",
			"world": "destination",
			"dimension": "destination.dimension()",
			"entity": "newEntity"
			}/>
		</#compress></#assign>
		if (!(newEntity instanceof Player))
		    execute(${dependenciesCode});
	});
	ServerEntityWorldChangeEvents.AFTER_PLAYER_CHANGE_WORLD.register((player, origin, destination) -> {
		<#assign dependenciesCode><#compress>
        	<@procedureDependenciesCode dependencies, {
        	"x": "player.getX()",
        	"y": "player.getY()",
        	"z": "player.getZ()",
        	"world": "destination",
        	"dimension": "destination.dimension()",
        	"entity": "player"
        	}/>
        </#compress></#assign>
		execute(${dependenciesCode});
	});
}
