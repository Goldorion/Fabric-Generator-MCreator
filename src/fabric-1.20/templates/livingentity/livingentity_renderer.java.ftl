<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2023, Pylo, opensource contributors
 # Copyright (C) 2020-2023, Goldorion, opensource contributors
 #
 # Fabric-Generator-MCreator is free software: you can redistribute it and/or modify
 # it under the terms of the GNU Lesser General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.

 # Fabric-Generator-MCreator is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 # GNU Lesser General Public License for more details.
 #
 # You should have received a copy of the GNU Lesser General Public License
 # along with Fabric-Generator-MCreator.  If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->
package ${package}.client.renderer;

import net.fabricmc.api.Environment;

<#assign humanoid = false>
<#assign model = "HumanoidModel">

<#if data.mobModelName == "Chicken">
	<#assign super = "super(context, new ChickenModel(context.bakeLayer(ModelLayers.CHICKEN)), " + data.modelShadowSize + "f);">
	<#assign model = "ChickenModel">
<#elseif data.mobModelName == "Cow">
	<#assign super = "super(context, new CowModel(context.bakeLayer(ModelLayers.COW)), " + data.modelShadowSize + "f);">
	<#assign model = "CowModel">
<#elseif data.mobModelName == "Creeper">
	<#assign super = "super(context, new CreeperModel(context.bakeLayer(ModelLayers.CREEPER)), " + data.modelShadowSize + "f);">
	<#assign model = "CreeperModel">
<#elseif data.mobModelName == "Ghast">
	<#assign super = "super(context, new GhastModel(context.bakeLayer(ModelLayers.GHAST)), " + data.modelShadowSize + "f);">
	<#assign model = "GhastModel">
<#elseif data.mobModelName == "Pig">
	<#assign super = "super(context, new PigModel(context.bakeLayer(ModelLayers.PIG)), " + data.modelShadowSize + "f);">
	<#assign model = "PigModel">
<#elseif data.mobModelName == "Slime">
	<#assign super = "super(context, new SlimeModel(context.bakeLayer(ModelLayers.SLIME)), " + data.modelShadowSize + "f);">
	<#assign model = "SlimeModel">
<#elseif data.mobModelName == "Spider">
	<#assign super = "super(context, new SpiderModel(context.bakeLayer(ModelLayers.SPIDER)), " + data.modelShadowSize + "f);">
	<#assign model = "SpiderModel">
<#elseif data.mobModelName == "Villager">
	<#assign super = "super(context, new VillagerModel(context.bakeLayer(ModelLayers.VILLAGER)), " + data.modelShadowSize + "f);">
	<#assign model = "VillagerModel">
<#elseif data.mobModelName == "Silverfish">
	<#assign super = "super(context, new SilverfishModel(context.bakeLayer(ModelLayers.SILVERFISH)), " + data.modelShadowSize + "f);">
	<#assign model = "SilverfishModel">
<#elseif !data.isBuiltInModel()>
	<#assign super = "super(context, new ${data.mobModelName}(context.bakeLayer(${data.mobModelName}.LAYER_LOCATION)), " + data.modelShadowSize + "f);">
	<#assign model = data.mobModelName>
<#else>
	<#assign super = "super(context, new HumanoidModel(context.bakeLayer(ModelLayers.PLAYER)), " + data.modelShadowSize + "f);">
	<#assign model = "HumanoidModel">
	<#assign humanoid = true>
</#if>

<#assign model = model + "<" + name + "Entity>">

public class ${name}Renderer extends <#if humanoid>Humanoid</#if>MobRenderer<${name}Entity, ${model}> {

	public ${name}Renderer(EntityRendererProvider.Context context) {
		${super}

		<#if humanoid>
		this.addLayer(new HumanoidArmorLayer(this, new HumanoidModel(context.bakeLayer(ModelLayers.PLAYER_INNER_ARMOR)),
				new HumanoidModel(context.bakeLayer(ModelLayers.PLAYER_OUTER_ARMOR))));
		</#if>

		<#if data.mobModelGlowTexture?has_content>
		this.addLayer(new EyesLayer<${name}Entity, ${model}>(this) {
			@Override public RenderType renderType() {
				return RenderType.eyes(new ResourceLocation("${modid}:textures/entities/${data.mobModelGlowTexture}"));
			}
		});
		</#if>
	}

	@Override public ResourceLocation getTextureLocation(${name}Entity entity) {
		return new ResourceLocation("${modid}:textures/entities/${data.mobModelTexture}"); 
	}

}
