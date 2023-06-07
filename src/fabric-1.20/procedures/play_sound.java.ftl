<#include "mcelements.ftl">
if (world instanceof Level _level) {
	if (!_level.isClientSide()) {
		_level.playSound(null, ${toBlockPos(input$x,input$y,input$z)},
			<#if generator.map(field$sound, "sounds").startsWith("CUSTOM:")>
			${JavaModName}Sounds.${generator.map(field$sound, "sounds")?replace("CUSTOM:", "")?upper_case},
			SoundSource.${generator.map(field$soundcategory!"neutral", "soundcategories")}, ${opt.toFloat(input$level)}, ${opt.toFloat(input$pitch)});
			<#else>
				<#assign s=generator.map(field$sound, "sounds")>
				BuiltInRegistries.SOUND_EVENT.get(new ResourceLocation("${s}")),
						SoundSource.${generator.map(field$soundcategory!"neutral", "soundcategories")}, ${opt.toFloat(input$level)}, ${opt.toFloat(input$pitch)});
			</#if>
	} else {
		_level.playLocalSound(${input$x}, ${input$y}, ${input$z},
			<#if generator.map(field$sound, "sounds").startsWith("CUSTOM:")>
			${JavaModName}Sounds.${generator.map(field$sound, "sounds")?replace("CUSTOM:", "")?upper_case},
			SoundSource.${generator.map(field$soundcategory!"neutral", "soundcategories")}, ${opt.toFloat(input$level)}, ${opt.toFloat(input$pitch)}, false);
			<#else>
			BuiltInRegistries.SOUND_EVENT.get(new ResourceLocation("${s}")),
						SoundSource.${generator.map(field$soundcategory!"neutral", "soundcategories")}, ${opt.toFloat(input$level)}, ${opt.toFloat(input$pitch)}, false);
			</#if>
	}
}