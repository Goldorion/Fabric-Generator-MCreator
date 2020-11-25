if(${input$entity} instanceof PlayerEntity) {
    ((PlayerEntity)${input$entity}).abilities.allowModifyWorld = ${input$condition};
    ((PlayerEntity)${input$entity}).sendAbilitiesUpdate();
}