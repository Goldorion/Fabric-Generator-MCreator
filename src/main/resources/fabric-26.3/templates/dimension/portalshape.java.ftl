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

package ${package}.world.teleporter;

public class ${name}PortalShape ${mcc.getClassBody("net.minecraft.world.level.portal.PortalShape")
        .replace("private PortalShape", "public " + name + "PortalShape")
        .replace("new PortalShape(", "new " + name + "PortalShape(")
        .replace("Optional<PortalShape>", "Optional<" + name + "PortalShape>")
        .replace("Predicate<PortalShape>", "Predicate<" + name + "PortalShape>")
        .replace("static PortalShape ", "static " + name + "PortalShape ")
        .replace("state.is(BlockTags.FIRE) || state.is(Blocks.NETHER_PORTAL)", "state.is(" + JavaModName + "Blocks." + REGISTRYNAME + "_PORTAL)")
        .replace("state.is(Blocks.NETHER_PORTAL)", "state.is(" + JavaModName + "Blocks." + REGISTRYNAME + "_PORTAL)")
        .replace("Blocks.NETHER_PORTAL.defaultBlockState()", JavaModName + "Blocks." + REGISTRYNAME + "_PORTAL.defaultBlockState()")
        .replace("(state, level, pos) -> state.is(Blocks.OBSIDIAN);", "(state, level, pos) -> state.is(" + mappedBlockToBlock(data.portalFrame) + ");")
        .replace("PortalShape.", "").replace("Optional collisionFreePosition", "Optional<Vec3> collisionFreePosition")}
<#-- @formatter:on -->