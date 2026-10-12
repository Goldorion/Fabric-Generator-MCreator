<#include "procedures.java.ftl">
public ${name}Procedure() {
	ServerEntityEvents.EQUIPMENT_CHANGE.register((entity, equipmentSlot, previousStack, currentStack) -> {
		<#assign dependenciesCode>
			<@procedureDependenciesCode dependencies, {
				"x": "entity.getX()",
				"y": "entity.getY()",
				"z": "entity.getZ()",
				"world": "entity.level()",
				"entity": "entity",
				"equipmentslot": "equipmentSlot.getId()",
				"olditemstack": "previousStack",
				"newitemstack": "currentStack"
			}/>
		</#assign>
		execute(${dependenciesCode});
	});
}