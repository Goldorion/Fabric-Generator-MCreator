<#include "procedures.java.ftl">
public ${name}Procedure() {
	ServerTickEvents.END_WORLD_TICK.register((level) -> {
		<#assign dependenciesCode>
		<@procedureDependenciesCode dependencies, {
			"world": "level"
			}/>
		</#assign>
		execute(${dependenciesCode});
	});
}
