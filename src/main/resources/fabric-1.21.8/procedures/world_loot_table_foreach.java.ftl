<#include "mcelements.ftl">
<#-- @formatter:off -->
<@head>if (!world.isClientSide() && world.getServer() != null) {</@head>
	BlockPos _bpLootTblWorld${cbi} = ${toBlockPos(input$x, input$y, input$z)};
	for (ItemStack itemstackiterator : world.getServer().reloadableRegistries().getLootTable(ResourceKey.create(Registries.LOOT_TABLE, ${toResourceLocation(input$location)}))
			.getRandomItems(new LootParams.Builder((ServerLevel) world)
					.withParameter(LootContextParams.ORIGIN, Vec3.atCenterOf(_bpLootTblWorld${cbi}))
					.withParameter(LootContextParams.BLOCK_STATE, world.getBlockState(_bpLootTblWorld${cbi}))
					.withOptionalParameter(LootContextParams.BLOCK_ENTITY, world.getBlockEntity(_bpLootTblWorld${cbi}))
					.create(LootContextParamSets.EMPTY))) {
		${statement$foreach}
	}
<@tail>}</@tail>
<#-- @formatter:on -->