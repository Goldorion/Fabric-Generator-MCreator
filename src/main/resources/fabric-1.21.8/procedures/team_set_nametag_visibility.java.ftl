<@head>if (world instanceof Level _level) {</@head>
	PlayerTeam _pt = _level.getScoreboard().getPlayerTeam(${input$name});
	if (_pt != null)
		_pt.setNameTagVisibility(Team.Visibility.${field$visibility});
<@tail>}</@tail>