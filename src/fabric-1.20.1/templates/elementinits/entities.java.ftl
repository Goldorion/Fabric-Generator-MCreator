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

/*
 *	MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

import net.fabricmc.fabric.api.object.builder.v1.entity.FabricEntityTypeBuilder;
import net.fabricmc.fabric.api.object.builder.v1.entity.FabricDefaultAttributeRegistry;

public class ${JavaModName}Entities {

	<#list entities as entity>
		public static EntityType<${entity.getModElement().getName()}Entity> ${entity.getModElement().getRegistryNameUpper()};

	</#list>

	public static void load() {
		<#list entities as entity>
			<#if entity.getModElement().getTypeString() == "projectile">
				${entity.getModElement().getRegistryNameUpper()} = Registry.register(BuiltInRegistries.ENTITY_TYPE, new ResourceLocation(${JavaModName}.MODID, "${entity.getModElement().getRegistryName()}"),
						createArrowEntityType(${entity.getModElement().getName()}Entity::new));
			<#else>
				${entity.getModElement().getRegistryNameUpper()} = Registry.register(BuiltInRegistries.ENTITY_TYPE, new ResourceLocation(${JavaModName}.MODID, "${entity.getModElement().getRegistryName()}"),
						FabricEntityTypeBuilder.create(${generator.map(entity.mobSpawningType, "mobspawntypes")}, ${entity.getModElement().getName()}Entity::new)
							.dimensions(new EntityDimensions(${entity.modelWidth}f, ${entity.modelHeight}f, true))<#if entity.immuneToFire>.fireImmune()</#if>
							.trackRangeBlocks(${entity.trackingRange})
							.forceTrackedVelocityUpdates(true).trackedUpdateRate(3)
							.build());

			${entity.getModElement().getName()}Entity.init();
			FabricDefaultAttributeRegistry.register(${entity.getModElement().getRegistryNameUpper()}, ${entity.getModElement().getName()}Entity.createAttributes());
			</#if>
		</#list>
	}

	private static <T extends Entity> EntityType<T> createArrowEntityType(EntityType.EntityFactory<T> factory) {
		return FabricEntityTypeBuilder.create(MobCategory.MISC, factory).dimensions(EntityDimensions.fixed(0.5f, 0.5f))
				.trackRangeBlocks(1).trackedUpdateRate(64).build();
	}

}
<#-- @formatter:on -->