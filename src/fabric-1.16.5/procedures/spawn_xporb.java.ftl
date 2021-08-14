if(world instanceof World && !world.isClient()) {
	world.spawnEntity(new ExperienceOrbEntity(world, ${input$x}, ${input$y}, ${input$z},(int)${input$xpamount}));
}