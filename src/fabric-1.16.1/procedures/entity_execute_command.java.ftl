{
	Entity _ent = ${input$entity};
	if(!_ent.world.isClient()) {
		_ent.world.getServer().getCommandManager().execute(_ent.getCommandSource()
			.withSilent().withLevel(4), ${input$command});
	}
}