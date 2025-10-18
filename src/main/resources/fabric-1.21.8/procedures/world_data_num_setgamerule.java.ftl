<#if generator.map(field$gamerulesnumber, "gamerules") != "null">
<@head>if (world instanceof ServerLevel _serverLevel) {</@head>
	_serverLevel.getGameRules().getRule(${generator.map(field$gamerulesnumber, "gamerules")}).set(${opt.toInt(input$gameruleValue)}, world.getServer());
<@tail>}</@tail>
</#if>