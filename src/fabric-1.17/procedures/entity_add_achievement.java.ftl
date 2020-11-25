if(${input$entity} instanceof ServerPlayerEntity) {
	Advancement _adv = ((MinecraftServer)((ServerPlayerEntity)${input$entity}).server).getAdvancementLoader()
        .get(new Identifier("${generator.map(field$achievement, "achievements")}"));
    AdvancementProgress _ap = ((ServerPlayerEntity) ${input$entity}).getAdvancementTracker().getProgress(_adv);
    if (!_ap.isDone()) {
        Iterator _iterator = _ap.getUnobtainedCriteria().iterator();
        while(_iterator.hasNext()) {
            String _criterion = (String)_iterator.next();
            ((ServerPlayerEntity) ${input$entity}).getAdvancementTracker().grantCriterion(_adv, _criterion);
        }
    }
}