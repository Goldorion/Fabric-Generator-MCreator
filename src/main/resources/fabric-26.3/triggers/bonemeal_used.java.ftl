<#include "procedures.java.ftl">
public ${name}Procedure() {
	ItemEvents.BONEMEAL_USED.register((position, entity, itemstack, blockstate) -> {
		<#assign dependenciesCode>
			<@procedureDependenciesCode dependencies, {
				"x": "position.getX()",
				"y": "position.getY()",
				"z": "position.getZ()",
				"world": "entity.level()",
				"itemstack": "itemstack",
				"entity": "entity",
				"blockstate": "blockstate"
			}/>
		</#assign>
		execute(${dependenciesCode});
		boolean result = eventResult;
		eventResult = true;
		return result;
	});
}