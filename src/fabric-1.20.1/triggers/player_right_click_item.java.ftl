<#include "procedures.java.ftl">
public ${name}Procedure() {
	UseItemCallback.EVENT.register((player, level, hand) -> {
		if (hand != player.getUsedItemHand())
			return InteractionResultHolder.fail(player.getItemInHand(hand));
		<#assign dependenciesCode><#compress>
			<@procedureDependenciesCode dependencies, {
			"x": "player.getX()",
			"y": "player.getY()",
			"z": "player.getZ()",
			"world": "level",
			"entity": "player"
			}/>
		</#compress></#assign>
		execute(${dependenciesCode});
		return InteractionResultHolder.pass(player.getItemInHand(hand));
	});
}
