if(!world.isClient()) {
		((ServerWorld) world).getServer().getCommandManager().execute(
			new ServerCommandSource(CommandOutput.DUMMY, new Vec3d(${input$x}, ${input$y}, ${input$z}), Vec2f.ZERO,
				(ServerWorld) world, 4, "", new LiteralText(""), ((ServerWorld) world).getServer(), null).withSilent(), ${input$command});
}