<#--
This file is part of MCreatorFabricGenerator.

MCreatorFabricGenerator is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

MCreatorFabricGenerator is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with MCreatorFabricGenerator.  If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->
package ${package}.mixin;

import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.gen.Accessor;

@Mixin(SetBaseBiomesLayer.class)
public interface SetBaseBiomesLayerAccessor {
    @Accessor("TEMPERATE_BIOMES")
    static int[] getTemperateBiomes() {
        throw new AssertionError();
    }

    @Accessor("TEMPERATE_BIOMES")
    static void setTemperateBiomes(int[] biomes) {
        throw new AssertionError();
    }
}

<#-- @formatter:on -->