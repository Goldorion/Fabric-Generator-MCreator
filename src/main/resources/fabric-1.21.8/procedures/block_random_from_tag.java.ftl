<#include "mcelements.ftl">
(BuiltInRegistries.BLOCK.getRandomElementOf(TagKey.create(Registries.BLOCK, ${toResourceLocation(input$tag)}), RandomSource.create())
	.orElseGet(() -> BuiltInRegistries.BLOCK.wrapAsHolder(Blocks.AIR)).value())