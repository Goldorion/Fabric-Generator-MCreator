<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2021, Pylo, opensource contributors
 # Copyright (C) 2020-2022, Goldorion, opensource contributors
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
<#include "triggers.java.ftl">

package ${package}.item;

import net.minecraft.network.chat.Component;
import net.fabricmc.api.Environment;

public class ${name}Item extends RecordItem {

	public ${name}Item() {
		<#if data.music.getUnmappedValue().startsWith("CUSTOM:")>
			super(${data.analogOutput}, ${JavaModName}Sounds.${data.music?replace(modid + ":", "")?upper_case},
					new Item.Properties().tab(${data.creativeTab}).stacksTo(1).rarity(Rarity.RARE), ${data.lengthInTicks});
		<#else>
		<#assign s=data.music>
			super(${data.analogOutput}, SoundEvents.${(s?starts_with("ambient")||s?starts_with("music")||s?starts_with("ui")||s?starts_with("weather"))?string(s?upper_case?replace(".", "_"),s?keep_after(".")?upper_case?replace(".", "_"))},
					new Item.Properties().tab(${data.creativeTab}).stacksTo(1).rarity(Rarity.RARE), ${data.lengthInTicks});
		</#if>
	}

	<#if data.hasGlow>
		@Override @Environment(EnvType.CLIENT) public boolean isFoil(ItemStack itemstack) {
			return true;
		}
	</#if>

	<#if data.specialInfo?has_content>
		@Override public void appendHoverText(ItemStack itemstack, Level world, List<Component> list, TooltipFlag flag) {
			super.appendHoverText(itemstack, world, list, flag);
			<#list data.specialInfo as entry>
				list.add(Component.literal("${JavaConventions.escapeStringForJava(entry)}"));
			</#list>
		}
	</#if>

	<@onRightClickedInAir data.onRightClickedInAir/>

	<@onItemUsedOnBlock data.onRightClickedOnBlock/>

	<@onEntityHitWith data.onEntityHitWith/>

	<@onCrafted data.onCrafted/>

	<@onStoppedUsing data.onStoppedUsing/>

	<@onItemTick data.onItemInUseTick, data.onItemInInventoryTick/>
}
<#-- @formatter:on -->