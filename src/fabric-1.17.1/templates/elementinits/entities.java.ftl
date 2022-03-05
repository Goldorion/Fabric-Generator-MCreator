<#--
 # This file is part of Fabric-Generator-MCreator.
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

/*
 *    MCreator note: This file will be REGENERATED on each build.
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
            <#if entity.getModElement().getTypeString() == "rangeditem">
                public static final EntityType<${entity.getModElement().getName()}Entity> ${entity.getModElement().getRegistryNameUpper()} =
                            register("projectile_${entity.getModElement().getRegistryName()}", EntityType.Builder.<${entity.getModElement().getName()}Entity>
                                of(${entity.getModElement().getName()}Entity::new, MobCategory.MISC).setCustomClientFactory(${entity.getModElement().getName()}Entity::new)
                                .setShouldReceiveVelocityUpdates(true).setTrackingRange(64).setUpdateInterval(1).sized(0.5f, 0.5f));
            <#else>
                ${entity.getModElement().getRegistryNameUpper()} = Registry.register(Registry.ENTITY_TYPE, new ResourceLocation(${JavaModName}.MODID, "${entity.getModElement().getRegistryName()}"),
                        FabricEntityTypeBuilder.create(${generator.map(entity.mobSpawningType, "mobspawntypes")}, ${entity.getModElement().getName()}Entity::new)
                            .dimensions(new EntityDimensions(${entity.modelWidth}f, ${entity.modelHeight}f, true))<#if entity.immuneToFire>.fireImmune()</#if>
                            .trackRangeBlocks(${entity.trackingRange})
                            .forceTrackedVelocityUpdates(true).trackedUpdateRate(3)
                            .build());
            </#if>
            ${entity.getModElement().getName()}Entity.init();
            FabricDefaultAttributeRegistry.register(${entity.getModElement().getRegistryNameUpper()}, ${entity.getModElement().getName()}Entity.createAttributes());
        </#list>
    }

}
<#-- @formatter:on -->