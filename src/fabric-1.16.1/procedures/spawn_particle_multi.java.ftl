if(world instanceof ServerWorld) {
		((ServerWorld)world).spawnParticles(ParticleTypes.${generator.map(field$particle, "particles")}, ${input$x}, ${input$y}, ${input$z},
		(int)${input$count}, ${input$dx}, ${input$dy}, ${input$dz}, ${input$speed});
}