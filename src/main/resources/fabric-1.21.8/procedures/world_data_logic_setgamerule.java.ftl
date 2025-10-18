<#if generator.map(field$gamerulesboolean, "gamerules") != "null">
<@head>if (world instanceof ServerLevel _serverLevel) {</@head>
	_serverLevel.getGameRules().getRule(${generator.map(field$gamerulesboolean, "gamerules")}).set(${input$gameruleValue}, world.getServer());
<@tail>}</@tail>
</#if>