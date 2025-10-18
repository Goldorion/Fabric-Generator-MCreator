<@head>if (world instanceof ServerLevel _origLevel) {</@head>
	LevelAccessor _worldorig${cbi} = world;
	world = _origLevel.getServer().getLevel(${generator.map(field$dimension, "dimensions")});

	if (world != null) {
		${statement$worldstatements}
	}
	world = _worldorig${cbi};
<@tail>}</@tail>