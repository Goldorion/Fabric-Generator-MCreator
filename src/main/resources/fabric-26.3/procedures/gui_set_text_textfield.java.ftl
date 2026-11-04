<#if types.guis?has_content>
if (${input$entity} instanceof Player _player && _player.containerMenu instanceof ${JavaModName}Menus.MenuAccessor _menu)
	_menu.sendMenuStateUpdate(_player, 0, "${field$textfield}", ${input$text}, true);
</#if>