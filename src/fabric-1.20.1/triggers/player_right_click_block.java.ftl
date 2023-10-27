<#include "procedures.java.ftl">
public ${name}Procedure() {
	UseBlockCallback.EVENT.register((player, level, hand, hitResult) -> {
		if (hand != player.getUsedItemHand())
			return InteractionResult.PASS;
		<#assign dependenciesCode><#compress>
			<@procedureDependenciesCode dependencies, {
			"x": "pos.getX()",
			"y": "pos.getY()",
			"z": "pos.getZ()",
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