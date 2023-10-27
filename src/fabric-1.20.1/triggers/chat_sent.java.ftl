<#include "procedures.java.ftl">
public ${name}Procedure() {
	ServerMessageEvents.CHAT_MESSAGE.register((message, sender, params) -> {
		<#assign dependenciesCode><#compress>
			<@procedureDependenciesCode dependencies, {
			"x": "sender.getX()",
			"y": "sender.getY()",
			"z": "sender.getZ()",
			"world": "sender.level()",
			"entity": "sender",
			"text": "message"
			}/>
		</#compress></#assign>
		execute(${dependenciesCode});
	});
}

