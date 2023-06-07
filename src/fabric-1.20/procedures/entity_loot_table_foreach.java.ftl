<#include "mcelements.ftl">
<#-- @formatter:off -->
if (${input$entity} instanceof LivingEntity _livingentity && !_livingentity.level.isClientSide() && _livingentity.getServer() != null) {
	DamageSource _ds = _livingentity.getLastDamageSource();
	if (_ds == null) _ds = DamageSource.GENERIC;
	for (ItemStack itemstackiterator : _livingentity.getServer().getLootTables().get(${toResourceLocation(input$location)})
			.getRandomItems(new LootContext.Builder((ServerLevel) _livingentity.level)
					.withParameter(LootContextParams.THIS_ENTITY, _livingentity)
					.withOptionalParameter(LootContextParams.LAST_DAMAGE_PLAYER, _livingentity.getLastHurtByMob() instanceof Player _player ?  _player : null)
					.withParameter(LootContextParams.DAMAGE_SOURCE, _ds)
					.withOptionalParameter(LootContextParams.KILLER_ENTITY, _ds.getEntity())
					.withOptionalParameter(LootContextParams.DIRECT_KILLER_ENTITY, _ds.getDirectEntity())
					.withParameter(LootContextParams.ORIGIN, _livingentity.position())
					.withParameter(LootContextParams.BLOCK_STATE, _livingentity.level.getBlockState(_livingentity.blockPosition()))
					.withOptionalParameter(LootContextParams.BLOCK_ENTITY, _livingentity.level.getBlockEntity(_livingentity.blockPosition()))
					.withParameter(LootContextParams.TOOL, _livingentity instanceof Player _player ? _player.getInventory().getSelected() : _livingentity.getUseItem())
					.withParameter(LootContextParams.EXPLOSION_RADIUS, 0f)
					.withLuck(_livingentity instanceof Player _player ? _player.getLuck() : 0)
					.create(LootContextParamSets.EMPTY))) {
		${statement$foreach}
	}
}
<#-- @formatter:on -->