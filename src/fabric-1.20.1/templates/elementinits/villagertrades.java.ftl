<#--
 # This file is part of Fabric-Generator-MCreator.
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
<#include "../mcitems.ftl">

/*
*	MCreator note: This file will be REGENERATED on each build.
*/

package ${package}.init;

<#compress>
import net.minecraft.world.entity.npc.VillagerTrades;

public class ${JavaModName}Trades {

	public static void registerTrades() {
		<#list villagertrades as trade>
			<#list trade.tradeEntries as tradeEntry>
				<#assign lv1 = []>
				<#assign lv2 = []>
				<#assign lv3 = []>
				<#assign lv4 = []>
				<#assign lv5 = []>
				
				<#list tradeEntry.entries as entry>
					<#if entry.level == 1>
						<#assign lv1 += [entry]>
					<#elseif entry.level == 2>
						<#assign lv2 += [entry]>
					<#elseif entry.level == 3>
						<#assign lv3 += [entry]>
					<#elseif entry.level == 4>
						<#assign lv4 += [entry]>
					<#elseif entry.level == 5>
						<#assign lv5 += [entry]>
					</#if>
				</#list>
				
				<@trades lv1, 1, tradeEntry.villagerProfession/>
				<@trades lv2, 2, tradeEntry.villagerProfession/>
				<@trades lv3, 3, tradeEntry.villagerProfession/>
				<@trades lv4, 4, tradeEntry.villagerProfession/>
				<@trades lv5, 5, tradeEntry.villagerProfession/>
			</#list>
		</#list>
	}

	private record BasicTrade(ItemStack price, ItemStack price2, ItemStack offer, int maxTrades, int xp,
							  float priceMult) implements VillagerTrades.ItemListing {

		@Override
		public @NotNull MerchantOffer getOffer(Entity entity, RandomSource random) {
			return new MerchantOffer(price, price2, offer, maxTrades, xp, priceMult);
		}
	}
}
</#compress>

<#macro trades entries level villagerProfession>
<#if entries?has_content>
	TradeOfferHelper.
		<#if villagerProfession == "WanderingTrader">registerWanderingTraderOffers(${level}
		<#else>registerVillagerOffers(${villagerProfession}, ${level}</#if>,
		factories -> {
			<#list entries as entry>
				factories.add(new BasicTrade(${mappedMCItemToItemStackCode(entry.price1, entry.countPrice1)},
					<#if !entry.price2.isEmpty()>${mappedMCItemToItemStackCode(entry.price2, entry.countPrice2)}
					<#else> ItemStack.EMPTY</#if>, ${mappedMCItemToItemStackCode(entry.offer, entry.countOffer)},
					${entry.maxTrades}, ${entry.xp}, ${entry.priceMultiplier}f)
				);
			</#list>
	});
</#if>
</#macro>
