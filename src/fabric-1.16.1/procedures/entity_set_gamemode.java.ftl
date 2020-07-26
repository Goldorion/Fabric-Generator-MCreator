if(${input$entity} instanceof PlayerEntity)
	((PlayerEntity)${input$entity}).setGameMode(GameMode.${generator.map(field$gamemode, "gamemodes")});