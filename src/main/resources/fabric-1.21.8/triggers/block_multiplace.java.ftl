<#include "procedures.java.ftl">
public ${name}Procedure() {
	BlockEvents.BLOCK_MULTIPLACE.register((position, entity, placed, placedAgainst) -> {
		<#assign dependenciesCode>
			<@procedureDependenciesCode dependencies, {
				"x": "position.getX()",
				"y": "position.getY()",
				"z": "position.getZ()",
				"px": "entity.getX()",
				"py": "entity.getY()",
				"pz": "entity.getZ()",
				"world": "entity.level()",
				"entity": "entity",
				"blockstate": "placed",
				"placedagainst": "placedAgainst"
			}/>
		</#assign>
		execute(${dependenciesCode});
		boolean result = eventResult;
		eventResult = true;
		return result;
	});
}