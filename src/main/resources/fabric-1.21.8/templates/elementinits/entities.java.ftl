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

<#assign hasLivingEntities = w.hasElementsOfType("livingentity")>

public class ${JavaModName}Entities {

	<#list entities as entity>
		public static EntityType<${entity.getModElement().getName()}Entity> ${entity.getModElement().getRegistryNameUpper()};
		<#if entity.getModElement().getTypeString() == "livingentity" && entity.hasCustomProjectile()>
			public static EntityType<${entity.getModElement().getName()}EntityProjectile> ${entity.getModElement().getRegistryNameUpper()}_PROJECTILE;
		</#if>
	</#list>

	public static void load() {
	<#list entities as entity>
		<#if entity.getModElement().getTypeString() == "projectile">
			${entity.getModElement().getRegistryNameUpper()} =
				register("${entity.getModElement().getRegistryName()}", EntityType.Builder.<${entity.getModElement().getName()}Entity>
						of(${entity.getModElement().getName()}Entity::new, MobCategory.MISC)
						.clientTrackingRange(64).updateInterval(1).sized(${entity.modelWidth}f, ${entity.modelHeight}f));
		<#elseif entity.getModElement().getTypeString() == "livingentity">
			${entity.getModElement().getRegistryNameUpper()} =
				register("${entity.getModElement().getRegistryName()}", EntityType.Builder.<${entity.getModElement().getName()}Entity>
						of(${entity.getModElement().getName()}Entity::new, ${generator.map(entity.mobSpawningType, "mobspawntypes")})
							.clientTrackingRange(${entity.trackingRange}).updateInterval(3)
							<#if entity.immuneToFire>.fireImmune()</#if>
							<#if entity.mobModelName == "Biped">.ridingOffset(-0.6f)</#if>
							.sized(${entity.modelWidth}f, ${entity.modelHeight}f)
						);
			<#if entity.hasCustomProjectile()>
			${entity.getModElement().getRegistryNameUpper()}_PROJECTILE =
				register("projectile_${entity.getModElement().getRegistryName()}", EntityType.Builder.<${entity.getModElement().getName()}EntityProjectile>
					of(${entity.getModElement().getName()}EntityProjectile::new, MobCategory.MISC).clientTrackingRange(64)
						.updateInterval(1).sized(0.5f, 0.5f));
			</#if>
		<#elseif entity.getModElement().getTypeString() == "specialentity">
			${entity.getModElement().getRegistryNameUpper()} =
				register("${entity.getModElement().getRegistryName()}",
				EntityType.Builder.<${entity.getModElement().getName()}Entity>of(${entity.getModElement().getName()}Entity::new, MobCategory.MISC)
					.noLootTable().sized(1.375F, 0.5625F).eyeHeight(0.5625F).clientTrackingRange(10));
		</#if>
	</#list>

		<#if hasLivingEntities>
			init();
			registerAttributes();
		</#if>
	}

	// Start of user code block custom entities
	// End of user code block custom entities

	private static <T extends Entity> EntityType<T> register(String registryname, EntityType.Builder<T> entityTypeBuilder) {
		return Registry.register(BuiltInRegistries.ENTITY_TYPE, ResourceLocation.fromNamespaceAndPath(${JavaModName}.MODID, registryname), (EntityType<T>) entityTypeBuilder.build(
				ResourceKey.create(Registries.ENTITY_TYPE, ResourceLocation.fromNamespaceAndPath(${JavaModName}.MODID, registryname))
		));
	}

	<#if hasLivingEntities>
	public static void init() {
		<#list entities as entity>
			<#if entity.getModElement().getTypeString() == "livingentity" && entity.spawnThisMob>
				${entity.getModElement().getName()}Entity.init();
			</#if>
		</#list>
	}

	public static void registerAttributes() {
		<#list entities as entity>
			<#if entity.getModElement().getTypeString() == "livingentity">
				FabricDefaultAttributeRegistry.register(${entity.getModElement().getRegistryNameUpper()}, ${entity.getModElement().getName()}Entity.createAttributes());
			</#if>
		</#list>
	}
	</#if>
}
<#-- @formatter:on -->