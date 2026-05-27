<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2026, Pylo, opensource contributors
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
package ${package}.world.dimension;

<@javacompress>
public class ${name}Dimension {

	public static void onPlayerChangedDimensionEvent() {
		ServerEntityLevelChangeEvents.AFTER_PLAYER_CHANGE_LEVEL.register((entity, origin, destination) -> {
            Level world = entity.level();
            double x = entity.getX();
            double y = entity.getY();
            double z = entity.getZ();

            <#if hasProcedure(data.onPlayerLeavesDimension)>
            if (origin.dimension() == ResourceKey.create(Registries.DIMENSION, Identifier.parse("${modid}:${registryname}"))) {
                <@procedureOBJToCode data.onPlayerLeavesDimension/>
            }
            </#if>

            <#if hasProcedure(data.onPlayerEntersDimension)>
            if (destination.dimension() == ResourceKey.create(Registries.DIMENSION, Identifier.parse("${modid}:${registryname}"))) {
                <@procedureOBJToCode data.onPlayerEntersDimension/>
            }
            </#if>
		});
	}
}
</@javacompress>
