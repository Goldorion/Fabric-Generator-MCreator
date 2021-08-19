if(world instanceof World && !world.isClient()) {
	((World) world).playSound(null, new BlockPos((int) ${input$x}, (int) ${input$y}, (int) ${input$z}),
    	new SoundEvent(new Identifier("${generator.map(field$sound, "sounds")?replace("CUSTOM:", "${modid}:")}")),
		SoundCategory.${generator.map(field$soundcategory!"neutral", "soundcategories")}, (float) ${input$level}, (float) ${input$pitch});
} else {
	((World) world).playSound(${input$x}, ${input$y}, ${input$z},
    	new SoundEvent(new Identifier("${generator.map(field$sound, "sounds")?replace("CUSTOM:", "${modid}:")}")),
		SoundCategory.${generator.map(field$soundcategory!"neutral", "soundcategories")}, (float) ${input$level}, (float) ${input$pitch}, false);
}