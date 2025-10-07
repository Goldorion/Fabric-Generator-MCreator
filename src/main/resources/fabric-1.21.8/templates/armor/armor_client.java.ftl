<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2025, Pylo, opensource contributors
 # Copyright (C) 2020-2025, Goldorion, opensource contributors
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
<#include "../mcitems.ftl">
<#include "../procedures.java.ftl">
<#include "../triggers.java.ftl">

package ${package}.client.renderer.item;

import net.minecraft.client.model.Model;

@Environment(EnvType.CLIENT) public class ${name}Armor {

	public static void clientLoad() {
		<#if data.enableHelmet>
		${JavaModName}ArmorModels.ARMOR_MODELS.put(${JavaModName}Items.${REGISTRYNAME}_HELMET, new ${JavaModName}ArmorModels.ArmorModel() {
			<#if data.helmetModelName != "Default" && data.getHelmetModel()??>
			@Override public HumanoidModel getHumanoidArmorModel(ItemStack itemStack, EquipmentClientInfo.LayerType layerType, Model original) {
				return new HumanoidModel(new ModelPart(Collections.emptyList(), Map.of(
					"head", new ModelPart(Collections.emptyList(), Map.of(
						"head", new ${data.helmetModelName}(Minecraft.getInstance().getEntityModels().bakeLayer(${data.helmetModelName}.LAYER_LOCATION)).${data.helmetModelPart},
						"hat", new ModelPart(Collections.emptyList(), Collections.emptyMap())
					)),
					"body", new ModelPart(Collections.emptyList(), Collections.emptyMap()),
					"right_arm", new ModelPart(Collections.emptyList(), Collections.emptyMap()),
					"left_arm", new ModelPart(Collections.emptyList(), Collections.emptyMap()),
					"right_leg", new ModelPart(Collections.emptyList(), Collections.emptyMap()),
					"left_leg", new ModelPart(Collections.emptyList(), Collections.emptyMap())
				)));
			}
			</#if>

			@Override public ResourceLocation getArmorTexture(ItemStack stack, EquipmentClientInfo.LayerType type, EquipmentClientInfo.Layer layer, ResourceLocation _default) {
				<#if data.helmetModelTexture?has_content && data.helmetModelTexture != "From armor">
				return ResourceLocation.parse("${modid}:textures/entities/${data.helmetModelTexture}");
				<#else>
				return ResourceLocation.parse("${modid}:textures/models/armor/${data.armorTextureFile}_layer_1.png");
				</#if>
			}
		});
		</#if>

		<#if data.enableBody>
		${JavaModName}ArmorModels.ARMOR_MODELS.put(${JavaModName}Items.${REGISTRYNAME}_CHESTPLATE, new ${JavaModName}ArmorModels.ArmorModel() {
			<#if data.bodyModelName != "Default" && data.getBodyModel()??>
			@Override public HumanoidModel getHumanoidArmorModel(ItemStack itemStack, EquipmentClientInfo.LayerType layerType, Model original) {
				return new HumanoidModel(new ModelPart(Collections.emptyList(), Map.of(
					"body", new ${data.bodyModelName}(Minecraft.getInstance().getEntityModels().bakeLayer(${data.bodyModelName}.LAYER_LOCATION)).${data.bodyModelPart},
					"left_arm", new ${data.bodyModelName}(Minecraft.getInstance().getEntityModels().bakeLayer(${data.bodyModelName}.LAYER_LOCATION)).${data.armsModelPartL},
					"right_arm", new ${data.bodyModelName}(Minecraft.getInstance().getEntityModels().bakeLayer(${data.bodyModelName}.LAYER_LOCATION)).${data.armsModelPartR},
					"head", new ModelPart(Collections.emptyList(), Map.of(
						"hat", new ModelPart(Collections.emptyList(), Collections.emptyMap())
					)),
					"right_leg", new ModelPart(Collections.emptyList(), Collections.emptyMap()),
					"left_leg", new ModelPart(Collections.emptyList(), Collections.emptyMap())
				)));
			}
			</#if>

			@Override public ResourceLocation getArmorTexture(ItemStack stack, EquipmentClientInfo.LayerType type, EquipmentClientInfo.Layer layer, ResourceLocation _default) {
				<#if data.bodyModelTexture?has_content && data.bodyModelTexture != "From armor">
				return ResourceLocation.parse("${modid}:textures/entities/${data.bodyModelTexture}");
				<#else>
				return ResourceLocation.parse("${modid}:textures/models/armor/${data.armorTextureFile}_layer_1.png");
				</#if>
			}
		});
		</#if>

		<#if data.enableLeggings>
		${JavaModName}ArmorModels.ARMOR_MODELS.put(${JavaModName}Items.${REGISTRYNAME}_LEGGINGS, new ${JavaModName}ArmorModels.ArmorModel() {
			<#if data.leggingsModelName != "Default" && data.getLeggingsModel()??>
			@Override public HumanoidModel getHumanoidArmorModel(ItemStack itemStack, EquipmentClientInfo.LayerType layerType, Model original) {
				return new HumanoidModel(new ModelPart(Collections.emptyList(), Map.of(
					"left_leg", new ${data.leggingsModelName}(Minecraft.getInstance().getEntityModels().bakeLayer(${data.leggingsModelName}.LAYER_LOCATION)).${data.leggingsModelPartL},
					"right_leg", new ${data.leggingsModelName}(Minecraft.getInstance().getEntityModels().bakeLayer(${data.leggingsModelName}.LAYER_LOCATION)).${data.leggingsModelPartR},
					"head", new ModelPart(Collections.emptyList(), Map.of(
						"hat", new ModelPart(Collections.emptyList(), Collections.emptyMap())
					)),
					"body", new ModelPart(Collections.emptyList(), Collections.emptyMap()),
					"right_arm", new ModelPart(Collections.emptyList(), Collections.emptyMap()),
					"left_arm", new ModelPart(Collections.emptyList(), Collections.emptyMap())
				)));
			}
			</#if>

			@Override public ResourceLocation getArmorTexture(ItemStack stack, EquipmentClientInfo.LayerType type, EquipmentClientInfo.Layer layer, ResourceLocation _default) {
				<#if data.leggingsModelTexture?has_content && data.leggingsModelTexture != "From armor">
				return ResourceLocation.parse("${modid}:textures/entities/${data.leggingsModelTexture}");
				<#else>
				return ResourceLocation.parse("${modid}:textures/models/armor/${data.armorTextureFile}_layer_2.png");
				</#if>
			}
		});
		</#if>

		<#if data.enableBoots>
		${JavaModName}ArmorModels.ARMOR_MODELS.put(${JavaModName}Items.${REGISTRYNAME}_BOOTS, new ${JavaModName}ArmorModels.ArmorModel() {
			<#if data.bootsModelName != "Default" && data.getBootsModel()??>
			@Override public HumanoidModel getHumanoidArmorModel(ItemStack itemStack, EquipmentClientInfo.LayerType layerType, Model original) {
				return new HumanoidModel(new ModelPart(Collections.emptyList(), Map.of(
					"left_leg", new ${data.bootsModelName}(Minecraft.getInstance().getEntityModels().bakeLayer(${data.bootsModelName}.LAYER_LOCATION)).${data.bootsModelPartL},
					"right_leg", new ${data.bootsModelName}(Minecraft.getInstance().getEntityModels().bakeLayer(${data.bootsModelName}.LAYER_LOCATION)).${data.bootsModelPartR},
					"head", new ModelPart(Collections.emptyList(), Map.of(
						"hat", new ModelPart(Collections.emptyList(), Collections.emptyMap())
					)),
					"body", new ModelPart(Collections.emptyList(), Collections.emptyMap()),
					"right_arm", new ModelPart(Collections.emptyList(), Collections.emptyMap()),
					"left_arm", new ModelPart(Collections.emptyList(), Collections.emptyMap())
				)));
			}
			</#if>

			@Override public ResourceLocation getArmorTexture(ItemStack stack, EquipmentClientInfo.LayerType type, EquipmentClientInfo.Layer layer, ResourceLocation _default) {
				<#if data.bootsModelTexture?has_content && data.bootsModelTexture != "From armor">
				return ResourceLocation.parse("${modid}:textures/entities/${data.bootsModelTexture}");
				<#else>
				return ResourceLocation.parse("${modid}:textures/models/armor/${data.armorTextureFile}_layer_1.png");
				</#if>
			}
		});
		</#if>
	}
}
<#-- @formatter:on -->