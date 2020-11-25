if(world instanceof World && !world.getWorld().isClient()) {
	world.getWorld().spawnEntity(new ExperienceOrbEntity(world.getWorld(), ${input$x}, ${input$y}, ${input$z},(int)${input$xpamount}));
}