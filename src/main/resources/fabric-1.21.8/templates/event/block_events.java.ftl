<#--
 # This file is part of Fabric-Generator-MCreator.
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
package ${package}.event;

public class BlockEvents {

	public static final Event<BlockMultiplace> BLOCK_MULTIPLACE = EventFactory.createArrayBacked(BlockMultiplace.class, (callbacks) -> (position, entity, placed, placedAgainst) -> {
		for (BlockMultiplace event : callbacks) {
			boolean result = event.onMultiplaced(position, entity, placed, placedAgainst);
			if (!result) {
				return false;
			}
		}
		return true;
	});

	public static final Event<BlockPlace> BLOCK_PLACE = EventFactory.createArrayBacked(BlockPlace.class, (callbacks) -> (position, entity, placed, placedAgainst) -> {
		for (BlockPlace event : callbacks) {
			boolean result = event.onBlockPlaced(position, entity, placed, placedAgainst);
			if (!result) {
				return false;
			}
		}
		return true;
	});

	@FunctionalInterface
	public interface BlockMultiplace {
		boolean onMultiplaced(BlockPos position, Entity entity, BlockState placed, BlockState placedAgainst);
	}

	@FunctionalInterface
	public interface BlockPlace {
		boolean onBlockPlaced(BlockPos position, Entity entity, BlockState placed, BlockState placedAgainst);
	}
}
<#-- @formatter:on -->