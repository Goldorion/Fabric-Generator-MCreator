<#if generator.map(field$gamerulesnumber, "gamerules") != "null">
	if(world instanceof ServerWorld && ((World) world).getServer() != null) {
    				((World) world).getServer().getCommandManager().execute(
    						new ServerCommandSource(CommandOutput.DUMMY, Vec3d.ZERO, Vec2f.ZERO,((ServerWorld)world),
    								4,"",new LiteralText(""),((World) world).getServer(),null).withSilent(),
    						String.format("gamerule %s %d",(${generator.map(field$gamerulesnumber, "gamerules")}).toString(), ${input$gameruleValue})
    		);
    }
</#if>