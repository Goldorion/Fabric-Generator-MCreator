<#include "procedures.java.ftl">
public ${name}Procedure() {
	UseEntityCallback.EVENT.register((player, level, hand, entity, hitResult) -> {
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
