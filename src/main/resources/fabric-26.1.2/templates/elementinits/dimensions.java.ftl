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
<#include "../procedures.java.ftl">
<#include "../mcitems.ftl">

/*
 *	MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

<@javacompress>
public class ${JavaModName}Dimensions {

	public static void load() {
		<#if dimensions?filter(e -> e.hasDimensionTriggers())?size != 0>
		ServerEntityLevelChangeEvents.AFTER_PLAYER_CHANGE_LEVEL.register((entity, origin, destination) -> {
            Level world = entity.level();
            double x = entity.getX();
            double y = entity.getY();
            double z = entity.getZ();
		<#list dimensions as dimension>
		    <#if dimension.hasDimensionTriggers()>
                <#if hasProcedure(dimension.onPlayerLeavesDimension)>
                if (origin.dimension() == ResourceKey.create(Registries.DIMENSION, Identifier.parse("${modid}:${dimension.getModElement().getRegistryName()}"))) {
                    <@procedureOBJToCode dimension.onPlayerLeavesDimension/>
                }
                </#if>

                <#if hasProcedure(dimension.onPlayerEntersDimension)>
                if (destination.dimension() == ResourceKey.create(Registries.DIMENSION, Identifier.parse("${modid}:${dimension.getModElement().getRegistryName()}"))) {
                    <@procedureOBJToCode dimension.onPlayerEntersDimension/>
                }
                </#if>
		    </#if>
		</#list>
		});
		</#if>

		<#list dimensions as dimension>
			<#if dimension.enablePortal>
				${dimension.getModElement().getName()}Teleporter.registerPointOfInterest();
			</#if>
		</#list>
	}
}</@javacompress>
<#-- @formatter:on -->