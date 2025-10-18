private static Projectile initProjectileProperties(Projectile entityToSpawn_${cbi}, Entity shooter, Vec3 acceleration) {
	entityToSpawn_${cbi}.setOwner(shooter);
	if (!Vec3.ZERO.equals(acceleration)) {
		entityToSpawn_${cbi}.setDeltaMovement(acceleration);
		entityToSpawn_${cbi}.hasImpulse = true;
	}
	return entityToSpawn_${cbi};
}