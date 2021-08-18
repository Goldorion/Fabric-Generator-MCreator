(new Object() {
    public boolean hasRecipe(Entity _ent, Identifier recipe) {
        if (_ent instanceof ServerPlayerEntity)
            return ((ServerPlayerEntity)_ent).getRecipeBook().contains(recipe);
        else if (_ent.world.isRemote() && _ent instanceof ClientPlayerEntity)
            return ((ClientPlayerEntity)_ent).getRecipeBook().contains(recipe);
        return false;
    }
}.hasRecipe(${input$entity}, new Identifier(${input$recipe})))