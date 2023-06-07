{
	Entity _ent = ${input$entity};
	if(!_ent.getLevel().isClientSide() && _ent.getServer() != null)
		_ent.getServer().getCommands().performPrefixedCommand(_ent.createCommandSourceStack().withSuppressedOutput().withPermission(4), ${input$command});
}