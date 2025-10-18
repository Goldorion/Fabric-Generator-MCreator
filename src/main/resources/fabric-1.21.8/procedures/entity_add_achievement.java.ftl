<@head>if(${input$entity} instanceof ServerPlayer _player && _player.level() instanceof ServerLevel _level) {</@head>
	AdvancementHolder _adv${cbi} = _level.getServer().getAdvancements().get(ResourceLocation.parse("${generator.map(field$achievement, "achievements")}"));
	if (_adv${cbi} != null) {
		AdvancementProgress _ap = _player.getAdvancements().getOrStartProgress(_adv${cbi});
		if (!_ap.isDone()) {
			for (String criteria : _ap.getRemainingCriteria())
				_player.getAdvancements().award(_adv${cbi}, criteria);
		}
	}
<@tail>}</@tail>