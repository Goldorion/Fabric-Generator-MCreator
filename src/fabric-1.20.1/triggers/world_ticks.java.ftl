<#include "procedures.java.ftl">
public ${name}Procedure() {
	ServerTickEvents.END_WORLD_TICK.register((level) -> {
		<#assign dependenciesCode><#compress>
		<@procedureDependenciesCode dependencies, {
			"world": "level"
			}/>
		</#compress></#assign>
		execute(${dependenciesCode});
	});
}
