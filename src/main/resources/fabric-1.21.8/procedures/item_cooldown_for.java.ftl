<#include "mcitems.ftl">
<@head>if(${input$entity} instanceof Player _player) {</@head>
	_player.getCooldowns().addCooldown(${mappedMCItemToItemStackCode(input$item)}, ${opt.toInt(input$ticks)});
<@tail>}</@tail>