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
<#include "../procedures.java.ftl">

package ${package}.mixin;

@Mixin(PiglinAi.class)
public abstract class PiglinAiMixin {
	@Inject(method = "isWearingSafeArmor(Lnet/minecraft/world/entity/LivingEntity;)Z", at = @At("HEAD"), cancellable = true)
	private static void isWearingSafeArmor(LivingEntity entity, CallbackInfoReturnable<Boolean> cir) {
		for (EquipmentSlot equipmentslot : EquipmentSlotGroup.ARMOR) {
			<#list armors as armor>
				<#if armor.enableHelmet && (hasProcedure(armor.helmetPiglinNeutral) || armor.helmetPiglinNeutral.getFixedValue())>
					if (entity.getItemBySlot(equipmentslot).getItem() instanceof ${armor.getModElement().getName()}Item.Helmet helmet)
						if (helmet.makesPiglinsNeutral(entity.getItemBySlot(equipmentslot), entity))
							cir.setReturnValue(true);
				</#if>
				<#if armor.enableBody && (hasProcedure(armor.bodyPiglinNeutral) || armor.bodyPiglinNeutral.getFixedValue())>
					if (entity.getItemBySlot(equipmentslot).getItem() instanceof ${armor.getModElement().getName()}Item.Chestplate chestplate)
						if (chestplate.makesPiglinsNeutral(entity.getItemBySlot(equipmentslot), entity))
							cir.setReturnValue(true);
				</#if>
				<#if armor.enableLeggings && (hasProcedure(armor.leggingsPiglinNeutral) || armor.leggingsPiglinNeutral.getFixedValue())>
					if (entity.getItemBySlot(equipmentslot).getItem() instanceof ${armor.getModElement().getName()}Item.Leggings leggings)
						if (leggings.makesPiglinsNeutral(entity.getItemBySlot(equipmentslot), entity))
							cir.setReturnValue(true);
				</#if>
				<#if armor.enableBoots && (hasProcedure(armor.bootsPiglinNeutral) || armor.bootsPiglinNeutral.getFixedValue())>
					if (entity.getItemBySlot(equipmentslot).getItem() instanceof ${armor.getModElement().getName()}Item.Boots boots)
						if (boots.makesPiglinsNeutral(entity.getItemBySlot(equipmentslot), entity))
							cir.setReturnValue(true);
				</#if>
			</#list>
		}
	}
}
<#-- @formatter:on -->