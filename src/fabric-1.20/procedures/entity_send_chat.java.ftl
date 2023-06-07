if (${input$entity} instanceof Player _player && !_player.getLevel().isClientSide())
	_player.displayClientMessage(Component.literal(${input$text}), ${input$actbar});