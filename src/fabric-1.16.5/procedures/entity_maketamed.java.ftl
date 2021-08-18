if ((${input$entity} instanceof TameableEntity) && (${input$sourceentity} instanceof PlayerEntity)) {
	((TameableEntity) ${input$entity}).setTamed(true);
	((TameableEntity) ${input$entity}).setOwner((PlayerEntity) ${input$sourceentity});
}