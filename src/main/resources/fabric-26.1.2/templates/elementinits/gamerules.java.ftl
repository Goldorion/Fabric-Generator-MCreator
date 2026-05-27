<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2025, Pylo, opensource contributors
 # Copyright (C) 2020-20256, Goldorion, opensource contributors
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

package ${package}.init;

<#assign hasLogicRules = false>
<#assign hasNumberRules = false>

public class ${JavaModName}GameRules {

	<#list gamerules as gamerule>
		<#if gamerule.type == "Number">
            <#assign hasNumberRules = true>
            public static final GameRule<Integer> ${gamerule.getModElement().getRegistryNameUpper()} = registerInt(${gamerule.defaultValueNumber},
                GameRuleCategory.${gamerule.category}, "${StringUtils.camelToSnake(gamerule.getModElement().getName())?lower_case}");
		<#else>
            <#assign hasLogicRules = true>
            public static final GameRule<Boolean> ${gamerule.getModElement().getRegistryNameUpper()} = registerBoolean(${gamerule.defaultValueLogic},
                GameRuleCategory.${gamerule.category}, "${StringUtils.camelToSnake(gamerule.getModElement().getName())?lower_case}");
		</#if>
	</#list>

	public static void load() {}

    <#if hasNumberRules>
	private static GameRule<Integer> registerInt(int defaultValue, GameRuleCategory category, String registryName) {
		return GameRuleBuilder.forInteger(defaultValue).category(category).buildAndRegister(Identifier.fromNamespaceAndPath(${JavaModName}.MODID, registryName));
	}
    </#if>

	<#if hasLogicRules>
	private static GameRule<Boolean> registerBoolean(boolean defaultValue, GameRuleCategory category, String registryName) {
		return GameRuleBuilder.forBoolean(defaultValue).category(category).buildAndRegister(Identifier.fromNamespaceAndPath(${JavaModName}.MODID, registryName));
	}
    </#if>
}
<#-- @formatter:on -->