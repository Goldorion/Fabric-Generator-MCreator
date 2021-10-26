<#include "mcitems.ftl">
/*@ItemStack*/
((world instanceof World && ((World) world).getRecipeManager().getFirstMatch(RecipeType.SMELTING, new SimpleInventory(${mappedMCItemToItemStackCode(input$item, 1)}), ((World) world)).isPresent()) ?
        ((World) world).getRecipeManager().getFirstMatch(RecipeType.SMELTING, new SimpleInventory(${mappedMCItemToItemStackCode(input$item, 1)}), (World) world).get().getOutput().copy()
        : ItemStack.EMPTY)