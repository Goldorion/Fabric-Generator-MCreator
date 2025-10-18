<@head>if (world instanceof Level _level) {
	PlayerTeam _pt = _level.getScoreboard().getPlayerTeam(${input$name});
</@head>
	if (_pt != null)
		_pt.setDeathMessageVisibility(Team.Visibility.${field$visibility});
<@tail>}</@tail>