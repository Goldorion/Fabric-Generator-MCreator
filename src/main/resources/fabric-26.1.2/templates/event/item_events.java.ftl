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

public class ItemEvents {

	public static final Event<BonemealUsed> BONEMEAL_USED = EventFactory.createArrayBacked(BonemealUsed.class, (callbacks) -> (position, entity, itemstack, blockstate) -> {
		for (BonemealUsed event : callbacks) {
			boolean result = event.onBonemealUsed(position, entity, itemstack, blockstate);
			if (!result) {
				return false;
			}
		}
		return true;
	});

	@FunctionalInterface
	public interface BonemealUsed {
		boolean onBonemealUsed(BlockPos position, Entity entity, ItemStack itemstack, BlockState blockstate);
	}

}
<#-- @formatter:on -->