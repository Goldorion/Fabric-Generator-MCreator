<#include "procedures.java.ftl">
public ${name}Procedure() {
	ServerWorldEvents.LOAD.register((server, world) -> {
		<#assign dependenciesCode>
			<@procedureDependenciesCode dependencies, {
			"world": "world"
			}/>
		</#assign>
		execute(${dependenciesCode});
	});
}