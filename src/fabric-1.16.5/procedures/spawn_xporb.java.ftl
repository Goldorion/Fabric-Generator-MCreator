if(world instanceof World && !world.getWorld().isClient()) {
	world.spawnEntity(new ExperienceOrbEntity(world, ${input$x}, ${input$y}, ${input$z},(int)${input$xpamount}));
}