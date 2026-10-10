<#include "procedures.java.ftl">
public ${name}Procedure() {
	MiscEvents.COMMAND_EXECUTE.register((results) -> {
		Entity entity = results.getContext().getSource().getEntity();
		if (entity != null) {
			<#assign dependenciesCode>
				<@procedureDependenciesCode dependencies, {
					"x": "entity.getX()",
					"y": "entity.getY()",
					"z": "entity.getZ()",
					"world": "entity.level()",
					"entity": "entity",
					"command": "results.getReader().getString()",
					"arguments": "results.getContext().build(results.getReader().getString())"
				}/>
			</#assign>
			execute(${dependenciesCode});
		}
		boolean result = eventResult;
		eventResult = true;
		return result;
	});
}