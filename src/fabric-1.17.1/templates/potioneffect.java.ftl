<#--
This file is part of Fabric-Generator-MCreator.

Fabric-Generator-MCreator is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Fabric-Generator-MCreator is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with Fabric-Generator-MCreator.  If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->
<#include "mcitems.ftl">
<#include "procedures.java.ftl">

package ${package}.potion;

public class ${name}StatusEffect extends StatusEffect {

	public ${name}StatusEffect() {
		super(
			StatusEffectCategory.<#if data.isBad>HARMFUL<#elseif data.isBenefitical>BENEFICIAL<#else>NEUTRAL</#if>,
			${data.color.getRGB()});
	}
	
	@Override public boolean isInstant() {
        return ${data.isInstant};
    }

	<#if hasProcedure(data.onStarted)>
	    <#if data.isInstant>
		    @Override
		    public void applyInstantEffect(Entity source, Entity indirectSource, LivingEntity entity, int amplifier, double health) {
				World world = entity.world;
				double x = entity.getX();
				double y = entity.getY();
				double z = entity.getZ();
				<@procedureOBJToCode data.onStarted/>
			}
		<#else>
			@Override
			public void onApplied(LivingEntity entity, AttributeContainer attributeMapIn, int amplifier) {
				World world = entity.world;
				double x = entity.getX();
				double y = entity.getY();
				double z = entity.getZ();
				<@procedureOBJToCode data.onStarted/>
			}
			</#if>
		</#if>

    <#if hasProcedure(data.onExpired)>
		@Override
		public void onRemoved(LivingEntity entity, AttributeContainer attributeMapIn, int amplifier) {
    		super.onRemoved(entity, attributeMapIn, amplifier);
    		World world = entity.world;
			double x = entity.getX();
			double y = entity.getY();
			double z = entity.getZ();
			<@procedureOBJToCode data.onExpired/>
		}
	</#if>

	<#if hasProcedure(data.onActiveTick)>
	    @Override
	    public void applyUpdateEffect(LivingEntity entity, int amplifier) {
	        World world = entity.world;
			double x = entity.getX();
			double y = entity.getY();
			double z = entity.getZ();
		    <@procedureOBJToCode data.onActiveTick/>
	    }
	</#if>

	@Override
	public boolean canApplyUpdateEffect(int duration, int amplifier) {
	    <#if hasProcedure(data.activeTickCondition)>
			return <@procedureOBJToConditionCode data.activeTickCondition/>;
		<#else>
			return true;
		</#if>
	}
}
<#-- @formatter:on -->
