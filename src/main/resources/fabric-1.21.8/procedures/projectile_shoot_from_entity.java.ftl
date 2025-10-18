{
	Entity _shootFrom = ${input$entity};
	Level projectileLevel = _shootFrom.level();
	if (!projectileLevel.isClientSide()) {
		Projectile _entityToSpawn_${cbi} = ${input$projectile};
		_entityToSpawn_${cbi}.setPos(_shootFrom.getX(), _shootFrom.getEyeY() - 0.1, _shootFrom.getZ());
		_entityToSpawn_${cbi}.shoot(_shootFrom.getLookAngle().x, _shootFrom.getLookAngle().y, _shootFrom.getLookAngle().z, ${opt.toFloat(input$speed)}, ${opt.toFloat(input$inaccuracy)});
		projectileLevel.addFreshEntity(_entityToSpawn_${cbi});
	}
}