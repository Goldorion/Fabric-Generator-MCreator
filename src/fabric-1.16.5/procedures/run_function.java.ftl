if(world instanceof ServerWorld && ((ServerWorld) world).getServer() != null) {
		Optional<CommandFunction> _fopt = ((ServerWorld) world).getServer().getCommandFunctionManager().getFunction(new Identifier(${input$function}));
		if(_fopt.isPresent()) {
			CommandFunction _fobj = _fopt.get();
			((ServerWorld) world).getServer().getCommandFunctionManager().execute(_fobj,
				new ServerCommandSource(CommandOutput.DUMMY, new Vec3d(${input$x}, ${input$y}, ${input$z}), Vec2f.ZERO,
					(ServerWorld) world, 4, "", new LiteralText(""), ((ServerWorld) world).getServer(), null));
		}
}