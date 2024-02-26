<#include "procedures.java.ftl">
public ${name}Procedure() {
	UseBlockCallback.EVENT.register((player, level, hand, hitResult) -> {
		if (hand != player.getUsedItemHand())
			return InteractionResult.PASS;
		<#assign dependenciesCode><#compress>
			<@procedureDependenciesCode dependencies, {
			"x": "hitResult.getBlockPos().getX()",
			"y": "hitResult.getBlockPos().getY()",
			"z": "hitResult.getBlockPos().getZ()",
			"world": "level",
			"entity": "player",
			"direction": "hitResult.getDirection()",
			"blockstate": "hitResult.getBlockPos()"
			}/>
		</#compress></#assign>
		execute(${dependenciesCode});

		return InteractionResult.PASS;
	});
}