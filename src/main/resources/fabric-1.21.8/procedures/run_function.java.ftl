<#include "mcelements.ftl">
<@head>if (world instanceof ServerLevel _level && _level.getServer() != null) {</@head>
	Optional<CommandFunction<CommandSourceStack>> _fopt${cbi} = _level.getServer().getFunctions().get(${toResourceLocation(input$function)});
	if(_fopt${cbi}.isPresent())
		_level.getServer().getFunctions().execute(_fopt${cbi}.get(),
			new CommandSourceStack(CommandSource.NULL, new Vec3(${input$x}, ${input$y}, ${input$z}), Vec2.ZERO,
				_level, 4, "", Component.literal(""), _level.getServer(), null));
<@tail>}</@tail>