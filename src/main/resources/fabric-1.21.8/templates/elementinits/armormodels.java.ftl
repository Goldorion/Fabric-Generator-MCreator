<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2025, Pylo, opensource contributors
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

/*
 *	MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

@Environment(EnvType.CLIENT) public class ${JavaModName}ArmorModels {
    public static Map<Item, ArmorModel> ARMOR_MODELS = new Reference2ObjectOpenHashMap<>();

    public static interface ArmorModel {
        default Model getHumanoidArmorModel(ItemStack itemStack, EquipmentClientInfo.LayerType layerType, Model original) {
            return original;
        }

        @Nullable default ResourceLocation getArmorTexture(ItemStack stack, EquipmentClientInfo.LayerType type, EquipmentClientInfo.Layer layer, ResourceLocation _default) {
            return null;
        }

        default Model getGenericArmorModel(ItemStack itemStack, EquipmentClientInfo.LayerType layerType, Model original) {
            Model replacement = getHumanoidArmorModel(itemStack, layerType, original);
            if (replacement != original) {
                if (original instanceof HumanoidModel<?> originalHumanoid && replacement instanceof HumanoidModel<?> replacementHumanoid) {
                    originalHumanoid.copyPropertiesTo((HumanoidModel) replacement);
                    replacementHumanoid.head.visible = originalHumanoid.head.visible;
                    replacementHumanoid.hat.visible = originalHumanoid.hat.visible;
                    replacementHumanoid.body.visible = originalHumanoid.body.visible;
                    replacementHumanoid.rightArm.visible = originalHumanoid.rightArm.visible;
                    replacementHumanoid.leftArm.visible = originalHumanoid.leftArm.visible;
                    replacementHumanoid.rightLeg.visible = originalHumanoid.rightLeg.visible;
                    replacementHumanoid.leftLeg.visible = originalHumanoid.leftLeg.visible;
                }
                return replacement;
            }
            return original;
        }
    }

    public static void clientLoad() {
        <#list armors as armor>
            ${armor.getModElement().getName()}Armor.clientLoad();
        </#list>
    }
}
<#-- @formatter:on -->