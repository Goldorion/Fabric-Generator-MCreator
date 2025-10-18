<@head>if (world instanceof ServerLevel projectileLevel) {</@head>
	Projectile _entityToSpawn_${cbi} = ${input$projectile};
	_entityToSpawn_${cbi}.setPos(${input$x}, ${input$y}, ${input$z});
	_entityToSpawn_${cbi}.shoot(${input$dx}, ${input$dy}, ${input$dz}, ${opt.toFloat(input$speed)}, ${opt.toFloat(input$inaccuracy)});
	projectileLevel.addFreshEntity(_entityToSpawn_${cbi});
<@tail>}</@tail>