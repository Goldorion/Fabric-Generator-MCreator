<#include "mcelements.ftl">
<@head>if (${input$entity} instanceof ServerPlayer _serverPlayer) {</@head>
	_serverPlayer.setRespawnPosition(new ServerPlayer.RespawnConfig(_serverPlayer.level().dimension(), ${toBlockPos(input$x,input$y,input$z)}, _serverPlayer.getYRot(), true), false);
<@tail>}</@tail>