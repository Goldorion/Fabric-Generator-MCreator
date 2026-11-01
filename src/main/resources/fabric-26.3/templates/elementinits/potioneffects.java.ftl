<#--
 # This file is part of Fabric-Generator-MCreator.
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

/*
 *	MCreator note: This file will be REGENERATED on each build.
 */

<#include "../procedures.java.ftl">

<#assign effects_that_expire = potioneffects?filter(effect -> hasProcedure(effect.onExpired))>
package ${package}.init;

public class ${JavaModName}MobEffects {

	<#list potioneffects as effect>
		public static Holder<MobEffect> ${effect.getModElement().getRegistryNameUpper()};
	</#list>

	public static void load() {
		<#list potioneffects as effect>
			${effect.getModElement().getRegistryNameUpper()} = register("${effect.getModElement().getRegistryName()}", ${effect.getModElement().getName()}MobEffect::new);
		</#list>

		<#if effects_that_expire?size != 0>
		ServerMobEffectEvents.AFTER_REMOVE.register((effect, entity, ctx) -> {
			if (!ctx.isFromCommand()) {
                <#list effects_that_expire as effect>
                    ${effect.getModElement().getName()}MobEffect.onExpired(effect, entity);
                </#list>
			}
		});
		</#if>
	}

	private static Holder<MobEffect> register(String registryname, Supplier<MobEffect> element) {
		return Holder.direct(Registry.register(BuiltInRegistries.MOB_EFFECT, Identifier.fromNamespaceAndPath(${JavaModName}.MODID, registryname), element.get()));
	}
}
<#-- @formatter:on -->