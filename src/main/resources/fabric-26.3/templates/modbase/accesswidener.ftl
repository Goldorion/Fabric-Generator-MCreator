classTweaker v1 official

<#list fragments.accesstransformer as fragment>
${fragment}
</#list>

accessible field net/minecraft/world/item/BucketItem content Lnet/minecraft/world/level/material/Fluid;
accessible field net/minecraft/world/level/block/LiquidBlock fluid Lnet/minecraft/world/level/material/FlowingFluid;

accessible method net/minecraft/world/item/CreativeModeTab$Builder type (Lnet/minecraft/world/item/CreativeModeTab$Type;)Lnet/minecraft/world/item/CreativeModeTab$Builder;

accessible method net/minecraft/world/item/Items registerItem (Lnet/minecraft/resources/ResourceKey;Ljava/util/function/Function;)Lnet/minecraft/world/item/Item;
accessible method net/minecraft/world/item/Items registerItem (Lnet/minecraft/resources/ResourceKey;Ljava/util/function/Function;Lnet/minecraft/world/item/Item$Properties;)Lnet/minecraft/world/item/Item;

# Start of user code block custom AWs
# End of user code block custom AWs