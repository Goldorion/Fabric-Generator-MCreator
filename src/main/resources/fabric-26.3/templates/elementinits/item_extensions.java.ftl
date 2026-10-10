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
<#include "../mcitems.ftl">
<#include "../procedures.java.ftl">

/*
 *	MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

<#assign proceduralFuels = itemextensions?filter(e -> e.enableFuel && (hasProcedure(e.fuelPower) || hasProcedure(e.fuelSuccessCondition)))>

<@javacompress>
public class ${JavaModName}ItemExtensions {

	public static void load() {
		<#if proceduralFuels?size != 0>
		Registry.register(BuiltInRegistries.CONTEXT_INT_PROVIDER_TYPE, Identifier.fromNamespaceAndPath(${JavaModName}.MODID, "fuel_power_procedural_provider"), ProcedureFuelProvider.CODEC);
		</#if>

		DefaultItemComponentEvents.MODIFY.register(context -> {
			<#list itemextensions?filter(e -> e.compostLayerChance gt 0) as extension>
			context.modify(${mappedMCItemToItem(extension.item)}, builder -> builder.set(DataComponents.COMPOSTABLE,
					new Compostable(ResourceKey.create(Registries.CONTEXT_INT_PROVIDER,
							Identifier.fromNamespaceAndPath(${JavaModName}.MODID, "compostable/${extension.getModElement().getRegistryName()}")))));
			</#list>
			<#list itemextensions?filter(e -> e.enableFuel) as extension>
			context.modify(${mappedMCItemToItem(extension.item)}, builder -> builder.set(DataComponents.COOKING_FUEL,
					new CookingFuel(ResourceKey.create(Registries.CONTEXT_INT_PROVIDER,
							Identifier.fromNamespaceAndPath(${JavaModName}.MODID, "fuel/${extension.getModElement().getRegistryName()}")),
							ContextFloatProviders.COOKING_DEFAULT_SPEED_MULTIPLIER)));
			</#list>
		});
	}
	<#if proceduralFuels?size != 0>

	public static final class ProcedureFuelProvider implements ContextIntProvider {

		public static final MapCodec<ProcedureFuelProvider> CODEC = RecordCodecBuilder.mapCodec(instance -> instance.group(
				Codec.STRING.fieldOf("item_extension").forGetter(provider -> provider.itemExtension)
		).apply(instance, ProcedureFuelProvider::new));

		private final String itemExtension;

		public ProcedureFuelProvider(String itemExtension) {
			this.itemExtension = itemExtension;
		}

		@Override public int getIntUnsafe(LootContext context) {
			<#list proceduralFuels as e>
			if (itemExtension.equals("${e.getModElement().getRegistryName()}")) {
				ItemStack itemstack = new ItemStack(${mappedMCItemToItem(e.item)});
				<#if hasProcedure(e.fuelSuccessCondition)>
				if (<@procedureOBJToConditionCode object=e.fuelSuccessCondition invertCondition=true/>)
					return 0;
				</#if>
				return (int) <#if hasProcedure(e.fuelPower)><@procedureOBJToNumberCode e.fuelPower/><#else>${e.fuelPower.getFixedValue()}</#if>;
			}
			</#list>
			return 0;
		}

		@Override public MapCodec<ProcedureFuelProvider> codec() {
			return CODEC;
		}

		@Override public void validate(ValidationContext context) {
		}
	}
	</#if>
}</@javacompress>
<#-- @formatter:on -->