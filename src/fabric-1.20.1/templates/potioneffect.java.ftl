<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2023, Pylo, opensource contributors
 # Copyright (C) 2020-2023, Goldorion, opensource contributors
 #
 # Fabric-Generator-MCreator is free software: you can redistribute it and/or modify
 # it under the terms of the GNU Lesser General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.

 # Fabric-Generator-MCreator is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 # GNU Lesser General Public License for more details.
 #
 # You should have received a copy of the GNU Lesser General Public License
 # along with Fabric-Generator-MCreator.  If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->
<#include "mcitems.ftl">
<#include "procedures.java.ftl">

package ${package}.potion;

public class ${name}MobEffect extends MobEffect {

	public ${name}MobEffect() {
		super(MobEffectCategory.<#if data.isBad>HARMFUL<#elseif data.isBenefitical>BENEFICIAL<#else>NEUTRAL</#if>, ${data.color.getRGB()});
	}

	@Override public String getDescriptionId() {
		return "effect.${modid}.${registryname}";
	}

	<#if data.isInstant>
		@Override public boolean isInstantenous() {
	   		return true;
   		}
   	</#if>

	<#if hasProcedure(data.onStarted)>
		<#if data.isInstant>
			@Override public void applyInstantenousEffect(Entity source, Entity indirectSource, LivingEntity entity, int amplifier, double health) {
				Level world = entity.level();
				double x = entity.getX();
				double y = entity.getY();
				double z = entity.getZ();
				<@procedureOBJToCode data.onStarted/>
			}
		<#else>
			@Override public void addAttributeModifiers(LivingEntity entity, AttributeMap attributeMap, int amplifier) {
				Level world = entity.level();
				double x = entity.getX();
				double y = entity.getY();
				double z = entity.getZ();
				<@procedureOBJToCode data.onStarted/>
			}
		</#if>
	</#if>

	<#if hasProcedure(data.onActiveTick)>
		@Override public void applyEffectTick(LivingEntity entity, int amplifier) {
			Level world = entity.level();
			double x = entity.getX();
			double y = entity.getY();
			double z = entity.getZ();
			<@procedureOBJToCode data.onActiveTick/>
	}
	</#if>

   	<#if hasProcedure(data.onExpired)>
		@Override public void removeAttributeModifiers(LivingEntity entity, AttributeMap attributeMap, int amplifier) {
   			super.removeAttributeModifiers(entity, attributeMap, amplifier);
   			Level world = entity.level();
			double x = entity.getX();
			double y = entity.getY();
			double z = entity.getZ();
			<@procedureOBJToCode data.onExpired/>
	}
	</#if>

	@Override public boolean isDurationEffectTick(int duration, int amplifier) {
			<#if hasProcedure(data.activeTickCondition)>
				return <@procedureOBJToConditionCode data.activeTickCondition/>;
			<#else>
				return true;
			</#if>
	}
}
<#-- @formatter:on -->
