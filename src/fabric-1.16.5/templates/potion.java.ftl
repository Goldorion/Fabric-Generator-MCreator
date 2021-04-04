<#--
This file is part of Fabric-Generator-MCreator.

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
<#include "mcitems.ftl">
<#include "procedures.java.ftl">

package ${package}.potion;

import net.minecraft.entity.effect.*;
import net.minecraft.potion.*;

public class ${name}Effect extends StatusEffect {

	public ${name}Effect() {
		super(
			StatusEffectType.<#if data.isBad>HARMFUL<#elseif data.isBenefitical>BENEFICIAL<#else>NEUTRAL</#if>,
			${data.color.getRGB()});
	}
	
	@Override public boolean isInstant() {
        return ${data.isInstant};
    }
		
	@Override
	public boolean canApplyUpdateEffect(int duration, int amplifier) {
		return true;
	}

	<#if hasProcedure(data.onActiveTick)>
	@Override
	public void applyUpdateEffect(LivingEntity entity, int amplifier) {
		World world = entity.world;
		int x = (int) entity.getX();
		int y = (int) entity.getY();
		int z = (int) entity.getZ();
		<@procedureOBJToCode data.onActiveTick/>
	}
	</#if>

	<#if data.registerPotionType>
	public static class ${name}Potion extends Potion {

		public ${name}Potion() {
			super(new StatusEffectInstance(INSTANCE, 3600));
		}

	}
	</#if>

	public static final StatusEffect INSTANCE = new ${name}Effect() {
	};

	<#if data.registerPotionType>
	public static final Potion POTION_INSTANCE = new ${name}Potion() {
	};
	</#if>
}
<#-- @formatter:on -->
