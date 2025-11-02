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
<#include "procedures.java.ftl">

package ${package}.potion;

<@javacompress>
public class ${name}MobEffect extends <#if data.isInstant>Instantenous</#if>MobEffect {

	public ${name}MobEffect() {
		super(MobEffectCategory.${data.mobEffectCategory}, ${data.color.getRGB()}<#if data.hasCustomParticle()>, ${data.particle}</#if>);
		<#if data.onAddedSound?has_content && data.onAddedSound.getMappedValue()?has_content>
		this.withSoundOnAdded(BuiltInRegistries.SOUND_EVENT.getValue(ResourceLocation.parse("${data.onAddedSound}")));
		</#if>
		<#list data.modifiers as modifier>
		this.addAttributeModifier(${modifier.attribute},
				ResourceLocation.fromNamespaceAndPath(${JavaModName}.MODID, "effect.${registryname}_${modifier?index}"),
				${modifier.amount}, AttributeModifier.Operation.${modifier.operation});
		</#list>
	}

	<#if hasProcedure(data.onStarted)>
		<#if data.isInstant>
			@Override public void applyInstantenousEffect(ServerLevel level, Entity source, Entity indirectSource, LivingEntity entity, int amplifier, double health) {
				<@procedureCode data.onStarted, {
					"x": "entity.getX()",
					"y": "entity.getY()",
					"z": "entity.getZ()",
					"world": "level",
					"entity": "entity",
					"amplifier": "amplifier"
				}/>
			}
		<#else>
			@Override public void onEffectStarted(LivingEntity entity, int amplifier) {
				<@procedureCode data.onStarted, {
					"x": "entity.getX()",
					"y": "entity.getY()",
					"z": "entity.getZ()",
					"world": "entity.level()",
					"entity": "entity",
					"amplifier": "amplifier"
				}/>
			}
		</#if>
	</#if>

	<#if hasProcedure(data.activeTickCondition) || hasProcedure(data.onActiveTick)>
		@Override public boolean shouldApplyEffectTickThisTick(int duration, int amplifier) {
			<#if hasProcedure(data.activeTickCondition)>
				return <@procedureOBJToConditionCode data.activeTickCondition/>;
			<#else>
				return true;
			</#if>
		}
	</#if>

	<#if hasProcedure(data.onActiveTick)>
		@Override public boolean applyEffectTick(ServerLevel level, LivingEntity entity, int amplifier) {
			<@procedureCode data.onActiveTick, {
				"x": "entity.getX()",
				"y": "entity.getY()",
				"z": "entity.getZ()",
				"world": "level",
				"entity": "entity",
				"amplifier": "amplifier"
			}/>
			return super.applyEffectTick(level, entity, amplifier);
		}
	</#if>

	<#if hasProcedure(data.onMobHurt)>
		@Override public void onMobHurt(ServerLevel level, LivingEntity entity, int amplifier, DamageSource damagesource, float damage) {
			<@procedureCode data.onMobHurt, {
				"x": "entity.getX()",
				"y": "entity.getY()",
				"z": "entity.getZ()",
				"world": "level",
				"entity": "entity",
				"amplifier": "amplifier",
				"damagesource": "damagesource",
				"damage": "damage"
			}/>
		}
	</#if>

	<#if hasProcedure(data.onMobRemoved)>
		@Override public void onMobRemoved(ServerLevel level, LivingEntity entity, int amplifier, Entity.RemovalReason reason) {
			if (reason == Entity.RemovalReason.KILLED) {
				<@procedureCode data.onMobRemoved, {
					"x": "entity.getX()",
					"y": "entity.getY()",
					"z": "entity.getZ()",
					"world": "level",
					"entity": "entity",
					"amplifier": "amplifier"
				}/>
			}
		}
	</#if>
}
</@javacompress>
<#-- @formatter:on -->