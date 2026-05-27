<#include "procedures.java.ftl">
public ${name}Procedure() {
	ServerPlayConnectionEvents.JOIN.register((handler, sender, server) -> {
		<#assign dependenciesCode>
			<@procedureDependenciesCode dependencies, {
			"x": "handler.getPlayer().getX()",
			"y": "handler.getPlayer().getY()",
			"z": "handler.getPlayer().getZ()",
			"world": "handler.getPlayer().level()",
			"entity": "handler.getPlayer()"
			}/>
		</#assign>
		execute(${dependenciesCode});
	});
}