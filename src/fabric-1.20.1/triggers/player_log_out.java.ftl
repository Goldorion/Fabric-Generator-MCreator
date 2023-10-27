<#include "procedures.java.ftl">
public ${name}Procedure() {
	ServerPlayConnectionEvents.DISCONNECT.register((handler, server) -> {
		<#assign dependenciesCode><#compress>
			<@procedureDependenciesCode dependencies, {
			"x": "handler.getPlayer().getX()",
			"y": "handler.getPlayer().getY()",
			"z": "handler.getPlayer().getZ()",
			"world": "handler.getPlayer().level()",
			"entity": "handler.getPlayer()"
			}/>
		</#compress></#assign>
		execute(${dependenciesCode});
	});
}