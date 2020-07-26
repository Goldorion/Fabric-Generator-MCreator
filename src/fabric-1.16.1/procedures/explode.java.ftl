if(!world.isClient()) {
	world.createExplosion(null,(int)${input$x},(int)${input$y},(int)${input$z},(float)${input$power}, Explosion.DestructionType.BREAK);
}