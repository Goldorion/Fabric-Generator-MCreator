<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2026, Pylo, opensource contributors
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

        @Nullable default Identifier getArmorTexture(ItemStack stack, EquipmentClientInfo.LayerType type, EquipmentClientInfo.Layer layer, Identifier _default) {
            return null;
        }

        default Model getGenericArmorModel(ItemStack itemStack, EquipmentClientInfo.LayerType layerType, Model original) {
            Model replacement = getHumanoidArmorModel(itemStack, layerType, original);
            if (replacement != original) {
                if (original instanceof HumanoidModel<?> originalHumanoid && replacement instanceof HumanoidModel<?> replacementHumanoid) {
                    copyModelPartProperties(originalHumanoid.head, replacementHumanoid.head);
                    copyModelPartProperties(originalHumanoid.hat, replacementHumanoid.hat);
                    copyModelPartProperties(originalHumanoid.body, replacementHumanoid.body);
                    copyModelPartProperties(originalHumanoid.rightArm, replacementHumanoid.rightArm);
                    copyModelPartProperties(originalHumanoid.leftArm, replacementHumanoid.leftArm);
                    copyModelPartProperties(originalHumanoid.rightLeg, replacementHumanoid.rightLeg);
                    copyModelPartProperties(originalHumanoid.leftLeg, replacementHumanoid.leftLeg);
                }
                return replacement;
            }
            return original;
        }

        private void copyModelPartProperties(ModelPart original, ModelPart replacement) {
            replacement.visible = original.visible;
            replacement.x = original.x;
            replacement.y = original.y;
            replacement.z = original.z;
            replacement.xRot = original.xRot;
            replacement.yRot = original.yRot;
            replacement.zRot = original.zRot;
            replacement.xScale = original.xScale;
            replacement.yScale = original.yScale;
            replacement.zScale = original.zScale;
        }
    }

    public static void clientLoad() {
        <#list armors as armor>
            ${armor.getModElement().getName()}Armor.clientLoad();
        </#list>
    }
}
<#-- @formatter:on -->