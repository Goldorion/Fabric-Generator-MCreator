if(${input$entity} instanceof PlayerEntity) {
    ((PlayerEntity)${input$entity}).abilities.invulnerable = ${input$condition};
    ((PlayerEntity)${input$entity}).sendAbilitiesUpdate();
}
