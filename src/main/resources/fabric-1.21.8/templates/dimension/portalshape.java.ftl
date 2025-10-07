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
<#include "../mcitems.ftl">

package ${package}.world.teleporter;

public class ${name}PortalShape ${mcc.getClassBody("net.minecraft.world.level.portal.PortalShape")
		.replace("class PortalShape", "class " + name + "PortalShape")
		.replace("private PortalShape", "public " + name + "PortalShape")
		.replace("new PortalShape(", "new " + name + "PortalShape(")
		.replace("Optional<PortalShape>", "Optional<" + name + "PortalShape>")
		.replace("Predicate<PortalShape>", "Predicate<" + name + "PortalShape>")
		.replace("static PortalShape ", "static " + name + "PortalShape ")
		<#--.replace("blockstate, 18);", "blockstate, 18);\nif (this.level instanceof ServerLevel) ((ServerLevel) this.level).getPoiManager().add(p_77725_, " + name + "Teleporter.poi);")-->
		.replace("p_77718_.is(BlockTags.FIRE) || p_77718_.is(Blocks.NETHER_PORTAL)", "p_77718_.getBlock() == " + JavaModName + "Blocks." + REGISTRYNAME + "_PORTAL")
		.replace("Blocks.NETHER_PORTAL.defaultBlockState()", JavaModName + "Blocks." + REGISTRYNAME + "_PORTAL.defaultBlockState()")
		.replace("PortalShape.", "")
		.replace("Optional optional = ", "Optional<Vec3> optional = ")
		.replace("Blocks.NETHER_PORTAL", JavaModName + "Blocks." + REGISTRYNAME + "_PORTAL")
		.replace("Blocks.OBSIDIAN", mappedBlockToBlock(data.portalFrame)?string)}

<#-- @formatter:on -->