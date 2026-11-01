<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2020-2026, Goldorion, opensource contributors
 #
 # Fabric-Generator-MCreator is free software: you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.
 #
 # Fabric-Generator-MCreator is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
 # along with Fabric-Generator-MCreator. If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->
package ${package};

@Environment(EnvType.CLIENT) public class ${JavaModName}Client implements ClientModInitializer {

	@Override
	public void onInitializeClient() {
		// Start of user code block mod constructor
		// End of user code block mod constructor

		<@javacompress>
		<#if w.hasJavaModels() || types["specialentities"]??>${JavaModName}Models.clientLoad();</#if>
		<#if types.blocks?filter(e -> e.tintType != "No tint")?size != 0 || types.plants?filter(e -> e.tintType != "No tint")?size != 0>${JavaModName}Blocks.clientLoad();</#if>
		<#if types.armors?has_content>${JavaModName}ArmorModels.clientLoad();</#if>
		<#if types.items?filter(e -> e.getModels()?filter(a -> a.hasCustomJAVAModel())?has_content || e.hasCustomJAVAModel())?size != 0>${JavaModName}ItemRenderers.clientLoad();</#if>
		<#if types.items?filter(e -> e.getModels()?has_content)?size != 0>LegacyOverrideSelectItemModel.clientLoad();</#if>
		<#if types.items?filter(e -> e.customProperties?has_content)?size != 0>${JavaModName}ItemProperties.clientLoad();</#if>
		<#if types.livingentities?has_content>${JavaModName}EntityRenderers.clientLoad();</#if>
		<#if types.particles?has_content>${JavaModName}Particles.clientLoad();</#if>
		<#if types.fluids?has_content>${JavaModName}Fluids.clientLoad();</#if>
		<#if types.guis?has_content>
		${JavaModName}Screens.clientLoad();
		${JavaModName}Menus.clientLoad();
		</#if>
		<#if types.overlaies?has_content>${JavaModName}Overlays.clientLoad();</#if>
		<#if types.commands?filter(e -> e.type == "CLIENTSIDE")?size != 0>${JavaModName}Commands.clientLoad();</#if>
		<#if types.keybinds?has_content>${JavaModName}KeyMappings.clientLoad();</#if>
		<#if types.dimensions?filter(e -> e.enableCustomSkyboxTextures || e.enableCustomSunMoonTextures)?size != 0>${JavaModName}SkyboxRenderer.renderSky();</#if>
		</@javacompress>

		<#if w.hasVariablesOfScope("GLOBAL_WORLD") || w.hasVariablesOfScope("GLOBAL_MAP")>
			ClientPlayNetworking.registerGlobalReceiver(${JavaModName}Variables.SavedDataSyncMessage.TYPE, ${JavaModName}Variables.SavedDataSyncMessage::handleData);
		</#if>

		<#if w.hasVariablesOfScope("PLAYER_LIFETIME") || w.hasVariablesOfScope("PLAYER_PERSISTENT")>
			ClientPlayNetworking.registerGlobalReceiver(${JavaModName}Variables.PlayerVariablesSyncMessage.TYPE, ${JavaModName}Variables.PlayerVariablesSyncMessage::handleData);
		</#if>

		// Start of user code block mod init
		// End of user code block mod init
	}

	// Start of user code block mod methods
	// End of user code block mod methods
}
<#-- @formatter:on -->