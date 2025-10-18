<@head>if (${input$entity} instanceof Player _player) {</@head>
	_player.getAbilities().flying = ${input$condition};
	_player.onUpdateAbilities();
<@tail>}</@tail>