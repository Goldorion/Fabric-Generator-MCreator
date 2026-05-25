<#include "mcelements.ftl">
<#-- @formatter:off -->
<@head>if (!world.isClientSide() && world.getServer() != null) {</@head>
	for (ItemStack itemstackiterator : world.getServer().reloadableRegistries().getLootTable(ResourceKey.create(Registries.LOOT_TABLE, ${toIdentifier(input$location)}))
			.getRandomItems(new LootParams.Builder((ServerLevel) world).create(LootContextParamSets.EMPTY))) {
		${statement$foreach}
	}
<@tail>}</@tail>
<#-- @formatter:on -->