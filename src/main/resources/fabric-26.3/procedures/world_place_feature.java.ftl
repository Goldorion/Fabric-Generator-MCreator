<#include "mcelements.ftl">
if (world instanceof ServerLevel _level)
	_level.holderLookup(Registries.CONFIGURED_FEATURE)
	        .get(ResourceKey.create(Registries.CONFIGURED_FEATURE, Identifier.parse("${generator.map(field$feature, "configuredfeatures")}")))
	        .get().value().place(_level, _level.getChunkSource().getGenerator(), _level.getRandom(), ${toBlockPos(input$x,input$y,input$z)});