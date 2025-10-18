<#include "mcelements.ftl">
<@head>if (${input$entity} instanceof ServerPlayer _serverPlayer && _serverPlayer.level() instanceof ServerLevel _serverLevel) {</@head>
	_serverLevel.getServer().getRecipeManager().byKey(ResourceKey.create(Registries.RECIPE, ${toResourceLocation(input$recipe)}))
		.ifPresent(_rec -> _serverPlayer.resetRecipes(Collections.singleton(_rec)));
<@tail>}</@tail>