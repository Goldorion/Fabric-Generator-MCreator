<#include "mcelements.ftl">
(BuiltInRegistries.ITEM.getRandomElementOf(TagKey.create(Registries.ITEM, ${toIdentifier(input$tag)}), RandomSource.create())
		.orElseGet(() -> BuiltInRegistries.ITEM.wrapAsHolder(Items.AIR)).value())