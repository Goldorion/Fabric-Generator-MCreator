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

public class ${JavaModName}Attributes {
	<#list attributes as attribute>
	public static Holder<Attribute> ${attribute.getModElement().getRegistryNameUpper()};
	</#list>

	public static void load() {
		<#list attributes as attribute>
			${attribute.getModElement().getRegistryNameUpper()} = register("${attribute.getModElement().getRegistryName()}",
					new RangedAttribute("attribute.${modid}.${attribute.getModElement().getRegistryName()}", ${attribute.defaultValue}, ${attribute.minValue}, ${attribute.maxValue}).setSyncable(true)
					<#if attribute.sentiment != "POSITIVE">.setSentiment(Attribute.Sentiment.${attribute.sentiment})</#if>);
		</#list>

		<#list attributes as attribute>
			<#if attribute.addToAllEntities>
				BuiltInRegistries.ENTITY_TYPE.stream().map((entityType) -> (EntityType<? extends LivingEntity>) entityType).filter(DefaultAttributes::hasSupplier)
					.forEach(entityType -> {
								FabricDefaultAttributeRegistry.register(entityType, addAttributeToEntity(DefaultAttributes.getSupplier(entityType), entityType, ${JavaModName}Attributes.${attribute.getModElement().getRegistryNameUpper()}));
						});
			<#else>
				<#if attribute.entities?has_content>
					List.of(
					<#list attribute.entities as entity>
						${generator.map(entity.getUnmappedValue(), "entities", 1)}<#sep>,
					</#list>
					).stream()
					.filter(DefaultAttributes::hasSupplier)
					.map(entityType -> (EntityType<? extends LivingEntity>) entityType)
					.collect(Collectors.toList()).forEach(entityType -> {
						FabricDefaultAttributeRegistry.register(entityType, addAttributeToEntity(DefaultAttributes.getSupplier(entityType), entityType, ${JavaModName}Attributes.${attribute.getModElement().getRegistryNameUpper()}));
					});
				</#if>
				<#if attribute.addToPlayers>
					FabricDefaultAttributeRegistry.register(EntityType.PLAYER, addAttributeToEntity(DefaultAttributes.getSupplier(EntityType.PLAYER), EntityType.PLAYER, ${JavaModName}Attributes.${attribute.getModElement().getRegistryNameUpper()}));
				</#if>
			</#if>
		</#list>
	}

	private static AttributeSupplier addAttributeToEntity(AttributeSupplier existingSupplier, EntityType<? extends LivingEntity> entityType, Holder<Attribute> newAttribute) {
		AttributeSupplier.Builder builder = AttributeSupplier.builder();
		AttributeSupplierAccessor accessor = (AttributeSupplierAccessor) existingSupplier;
		accessor.getInstances().forEach((attribute, instance) -> {
			builder.add(attribute, instance.getBaseValue());
		});
		return builder.add(newAttribute).build();
	}

	private static Holder<Attribute> register(String registryname, Attribute element) {
		return Registry.registerForHolder(BuiltInRegistries.ATTRIBUTE, ResourceLocation.fromNamespaceAndPath(${JavaModName}.MODID, registryname), element);
	}
}
<#-- @formatter:on -->