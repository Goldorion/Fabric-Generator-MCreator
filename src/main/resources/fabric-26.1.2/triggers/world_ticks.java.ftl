<#include "procedures.java.ftl">
public ${name}Procedure() {
	ServerTickEvents.END_LEVEL_TICK.register((level) -> {
		<#assign dependenciesCode>
		<@procedureDependenciesCode dependencies, {
			"world": "level"
			}/>
		</#assign>
		execute(${dependenciesCode});
	});
}