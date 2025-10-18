<@head>if (world instanceof Level _level) {
	PlayerTeam _pt = _level.getScoreboard().getPlayerTeam(${input$name});
</@head>
	if (_pt != null)
		_level.getScoreboard().removePlayerTeam(_pt);
<@tail>}</@tail>