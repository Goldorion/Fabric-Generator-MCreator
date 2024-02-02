<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2023, Pylo, opensource contributors
 # Copyright (C) 2020-2024, Goldorion, opensource contributors
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
					new Item.Properties().stacksTo(1).rarity(Rarity.${data.rarity}), ${data.lengthInTicks});
		<#else>
		<#assign s=data.music>
			super(${data.analogOutput}, BuiltInRegistries.SOUND_EVENT.get(new ResourceLocation("${s}")),
					new Item.Properties().stacksTo(1).rarity(Rarity.RARE), ${data.lengthInTicks});
		</#if>
		<#if data.creativeTab.getUnmappedValue() != "No creative tab entry">
			ItemGroupEvents.modifyEntriesEvent(${data.creativeTab}).register(content -> content.accept(this));
		</#if>
	}

	<@hasGlow data.glowCondition/>

	<@addSpecialInformation data.specialInformation/>

	<@onRightClickedInAir data.onRightClickedInAir/>

	<@onItemUsedOnBlock data.onRightClickedOnBlock/>

	<@onEntityHitWith data.onEntityHitWith/>

	<@onCrafted data.onCrafted/>

	<@onStoppedUsing data.onStoppedUsing/>

	<@onItemTick data.onItemInUseTick, data.onItemInInventoryTick/>
}
<#-- @formatter:on -->