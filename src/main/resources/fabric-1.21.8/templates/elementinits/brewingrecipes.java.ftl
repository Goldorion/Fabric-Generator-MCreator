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
<#include "../mcitems.ftl">
<#assign brewingRecipes = recipes?filter(recipe -> recipe.recipeType == "Brewing")>

/*
 *	MCreator note: This file will be REGENERATED on each build.
 */

package ${package}.init;

<@javacompress>
public class ${JavaModName}BrewingRecipes {

	public static void load() {
		FabricBrewingRecipeRegistryBuilder.BUILD.register((builder) -> {
			<#-- Fabric allows only potions as input and output -->
			<#list brewingRecipes as recipe>
				<#if recipe.brewingInputStack?starts_with("POTION:") && recipe.brewingReturnStack?starts_with("POTION:")>
					builder.registerPotionRecipe(${generator.map(recipe.brewingInputStack?replace("POTION:",""), "potions")},
							${mappedMCItemToIngredient(recipe.brewingIngredientStack)},
							${generator.map(recipe.brewingReturnStack?replace("POTION:",""), "potions")});
				</#if>
			</#list>
		});
	}
}
</@javacompress>
<#-- @formatter:on -->