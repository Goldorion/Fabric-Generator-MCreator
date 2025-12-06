<#--
 # This file is part of Fabric-Generator-MCreator.
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
<@javacompress>
<#include "../mcitems.ftl">

/*
*	MCreator note: This file will be REGENERATED on each build.
*/

package ${package}.init;

import net.minecraft.world.entity.npc.VillagerTrades;

public class ${JavaModName}Trades {

    private static final ResourceLocation CUSTOM_WANDERING_TRADER_POOL = ResourceLocation.fromNamespaceAndPath(${JavaModName}.MODID, "custom_wandering_trader_pool");

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
			return new MerchantOffer(new ItemCost(price.getItem(), price.getCount()), Optional.of(new ItemCost(price2.getItem(), price2.getCount())), offer, maxTrades, xp, priceMult);
		}
	}
}
</@javacompress>

<#macro trades entries level villagerProfession>
<#if entries?has_content>
	TradeOfferHelper.
		<#if villagerProfession == "WanderingTrader">registerWanderingTraderOffers(builder -> {
		    builder.pool(CUSTOM_WANDERING_TRADER_POOL, 5,
			<#list entries as entry>
				<@basicTrade entry.price1, entry.countPrice1, !entry.price2.isEmpty(), entry.price2, entry.countPrice2, entry.offer, entry.countOffer, entry.maxTrades, entry.xp, entry.priceMultiplier/><#sep>,
			</#list>
			);
		<#else>registerVillagerOffers(${villagerProfession}, ${level},
		builder -> {
			<#list entries as entry>
				builder.add(<@basicTrade entry.price1, entry.countPrice1, !entry.price2.isEmpty(), entry.price2, entry.countPrice2, entry.offer, entry.countOffer, entry.maxTrades, entry.xp, entry.priceMultiplier/>);
			</#list>
		</#if>
	});
</#if>
</#macro>

<#macro basicTrade price1 countPrice1 hasPrice2 price2 countPrice2 offer countOffer maxTrades xp priceMultiplier>
new BasicTrade(${mappedMCItemToItemStackCode(price1, countPrice1)},
    <#if hasPrice2>${mappedMCItemToItemStackCode(price2, countPrice2)}
	<#else> ItemStack.EMPTY</#if>, ${mappedMCItemToItemStackCode(offer, countOffer)},
	${maxTrades}, ${xp}, ${priceMultiplier}f
)
</#macro>