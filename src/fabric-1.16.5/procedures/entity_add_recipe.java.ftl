if(${input$entity} instanceof ServerPlayerEntity) {
    ((ServerPlayerEntity)${input$entity}).unlockRecipes(new Identifier[]{new Identifier(${input$recipe})});
}