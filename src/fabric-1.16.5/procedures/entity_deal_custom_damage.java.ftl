if (${input$entity} instanceof LivingEntity) {
    ((LivingEntity) ${input$entity}).damage(new DamageSource(${input$localization_text}).bypassesArmor(), (float) ${input$damage_number});
}
