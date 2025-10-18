private static AbstractArrow initArrowProjectile(AbstractArrow entityToSpawn_${cbi}, Entity shooter, float damage,
		boolean silent, boolean fire, boolean particles, AbstractArrow.Pickup pickup) {
	entityToSpawn_${cbi}.setOwner(shooter);
	entityToSpawn_${cbi}.setBaseDamage(damage);
	if (silent)
		entityToSpawn_${cbi}.setSilent(true);
	if (fire)
		entityToSpawn_${cbi}.igniteForSeconds(100);
	if (particles)
		entityToSpawn_${cbi}.setCritArrow(true);
	entityToSpawn_${cbi}.pickup = pickup;
	return entityToSpawn_${cbi};
}