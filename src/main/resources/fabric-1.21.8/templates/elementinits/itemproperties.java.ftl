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

/*
 *	MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

<#assign hasItemsWithLeftHandedProperty = w.getGElementsOfType("item")?filter(e -> e.states
	?filter(e -> e.stateMap.keySet()?filter(e -> e.getName() == "lefthanded")?size != 0)?size != 0)?size != 0>
@Environment(EnvType.CLIENT) public class ${JavaModName}ItemProperties {

	public static void clientLoad() {
		<#list items as item>
			<#list item.customProperties.entrySet() as property>
				RangeSelectItemModelProperties.ID_MAPPER.put(ResourceLocation.parse("${modid}:${item.getModElement().getRegistryName()}/${property.getKey()}"),
					${item.getModElement().getName()}Item.${StringUtils.snakeToCamel(property.getKey())}Property.MAP_CODEC);
			</#list>
		</#list>
		<#if hasItemsWithLeftHandedProperty>
			ConditionalItemModelProperties.ID_MAPPER.put(ResourceLocation.parse("${modid}:lefthanded"), LegacyLeftHandedProperty.MAP_CODEC);
		</#if>
	}

	<#if hasItemsWithLeftHandedProperty>
	public record LegacyLeftHandedProperty() implements ConditionalItemModelProperty {

		public static final MapCodec<LegacyLeftHandedProperty> MAP_CODEC = MapCodec.unit(new LegacyLeftHandedProperty());

		@Override
		public boolean get(ItemStack itemStackToRender, @Nullable ClientLevel clientWorld, @Nullable LivingEntity entity, int seed, ItemDisplayContext displayContext) {
			return entity != null && entity.getMainArm() == HumanoidArm.LEFT;
		}

		@Override
		public MapCodec<LegacyLeftHandedProperty> type() {
			return MAP_CODEC;
		}
	}
	</#if>
}
<#-- @formatter:on -->