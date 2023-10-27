<#include "procedures.java.ftl">
public ${name}Procedure() {
	AttackBlockCallback.EVENT.register((player, level, hand, pos, direction) -> {
		if (hand != player.getUsedItemHand())
			return InteractionResult.PASS;
		<#assign dependenciesCode><#compress>
			<@procedureDependenciesCode dependencies, {
			"x": "pos.getX()",
			"y": "pos.getY()",
			"z": "pos.getZ()",
			"world": "level",
			"entity": "player",
			"direction": "direction",
			"blockstate": "level.getBlockState(pos)"
			}/>
		</#compress></#assign>
		execute(${dependenciesCode});
		
		return InteractionResult.PASS;
	});
}