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

public class ${name}Teleporter {
	public static Holder<PoiType> poi = null;

	public static void registerPointOfInterest() {
		PoiType poiType = PointOfInterestHelper.register(ResourceLocation.parse("${modid}:${registryname}_portal"), 0, 1, ImmutableSet.copyOf(${JavaModName}Blocks.${REGISTRYNAME}_PORTAL.getStateDefinition().getPossibleStates()));
		poi = BuiltInRegistries.POINT_OF_INTEREST_TYPE.wrapAsHolder(poiType);
	}

	private final ServerLevel level;

	public ${name}Teleporter(ServerLevel level) {
		this.level = level;
	}

	${mcc.getMethod("net.minecraft.world.level.portal.PortalForcer", "findClosestPortalPosition", "BlockPos", "boolean", "WorldBorder")
		 .replace("PoiTypes.NETHER_PORTAL", "poi.unwrapKey().get()")
		 .replace("Comparator.comparingDouble", "Comparator.<BlockPos>comparingDouble")}

	${mcc.getMethod("net.minecraft.world.level.portal.PortalForcer", "createPortal", "BlockPos", "Direction.Axis")
		 .replace("Blocks.OBSIDIAN", mappedBlockToBlock(data.portalFrame)?string)
		 .replace(",blockstate,18);", ", blockstate, 18);\nthis.level.getPoiManager().add(blockpos$mutableblockpos, poi);")
		 .replace("Blocks.NETHER_PORTAL", JavaModName + "Blocks." + REGISTRYNAME + "_PORTAL")}

	${mcc.getMethod("net.minecraft.world.level.portal.PortalForcer", "canHostFrame", "BlockPos", "BlockPos.MutableBlockPos", "Direction", "int")}

	private boolean canPortalReplaceBlock(BlockPos.MutableBlockPos pos) {
		BlockState blockstate = this.level.getBlockState(pos);
		return blockstate.canBeReplaced() && blockstate.getFluidState().isEmpty();
	}
}
<#-- @formatter:on -->