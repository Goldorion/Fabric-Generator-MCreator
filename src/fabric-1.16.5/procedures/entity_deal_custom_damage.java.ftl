if (${input$entity} instanceof LivingEntity) {
    ((LivingEntity) ${input$entity}).damage(new EntityDamageSource(${input$localization_text}, ${input$entity}), (float) ${input$damage_number});
}
