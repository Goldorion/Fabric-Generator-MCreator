<#include "procedures.java.ftl">
public ${name}Procedure() {
	UseEntityCallback.EVENT.register((player, level, hand, entity, hitResult) -> {
		Map<String, Object> dependencies = new HashMap<>();
		dependencies.put("world", level);
		dependencies.put("sourceentity", player);
		dependencies.put("entity", entity);
		dependencies.put("x", player.getX());
		dependencies.put("y", player.getY());
		dependencies.put("z", player.getZ());
		execute(dependencies);
		
		if (hand != player).getUsedItemHand())
			return;
		<#assign dependenciesCode><#compress>
			<@procedureDependenciesCode dependencies, {
			"x": "entity.getX()",
			"y": "entity.getY()",
			"z": "entity.getZ()",
			"world": "level",
			"entity": "entity",
			"sourceentity": "player"
			}/>
		</#compress></#assign>
		execute(${dependenciesCode});
		return InteractionResult.PASS;
	});
}
