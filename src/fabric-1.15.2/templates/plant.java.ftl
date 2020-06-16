<#-- @formatter:off -->

package ${package}.block;

import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;
import net.fabricmc.fabric.api.object.builder.v1.block.FabricBlockSettings;

public class ${name} extends FlowerBlock{
  public ${name}() {
        super(StatusEffect.byRawId(23),1,FabricBlockSettings.of(
        <#if data.colorOnMap != "DEFAULT">
        Material.PLANT
        <#else>
        Material.PLANT,MaterialColor.${data.colorOnMap}
        </#if>
        )
        .noCollision()
        <#if data.unbreakable>
        .hardness(-1)
        .resistance(3600000)
        <#else>
        .hardness(${data.hardness}f)
        .resistance(${data.resistance}f)
        </#if>
        .lightLevel(${(data.luminance * 15)?round})
        );
  }

  @Override
  public OffsetType getOffsetType() {
      return OffsetType.${data.offsetType};
  }

  <#if data.isReplaceable>
  @Override
    public boolean canReplace(BlockState state, ItemPlacementContext ctx) {
        return true;
    }
    </#if>

    <#if data.creativePickItem?? && !data.creativePickItem.isEmpty()>
    @Override
    public ItemStack getPickStack(BlockView world, BlockPos pos, BlockState state) {
        return ${mappedMCItemToItemStackCode(data.creativePickItem, 1)};
    }
    </#if>

    <#if data.dropAmount != 1 && !(data.customDrop?? && !data.customDrop.isEmpty())>
    @Override
    public List<ItemStack> getDroppedStacks(BlockState state, LootContext.Builder builder) {
        List<ItemStack> dropsOriginal = super.getDroppedStacks(state, builder);
        if(!dropsOriginal.isEmpty())
            return dropsOriginal;
        return Collections.singletonList(new ItemStack(this, ${data.dropAmount}));
    }
    <#else>
    @Override
    public List<ItemStack> getDroppedStacks(BlockState state, LootContext.Builder builder) {
        List<ItemStack> dropsOriginal = super.getDroppedStacks(state, builder);
        if(!dropsOriginal.isEmpty())return dropsOriginal;
        return Collections.singletonList(new ItemStack(this, 1));
    }
    </#if>

    <#if data.specialInfo?has_content>
    @Environment(EnvType.CLIENT)
    @Override
     public void buildTooltip(ItemStack stack, BlockView view, List<Text> tooltip, TooltipContext options) {
      <#list data.specialInfo as entry>
        tooltip.add(new LiteralText("${JavaConventions.escapeStringForJava(entry)}"));
        </#list>
     }
    </#if>
}

<#-- @formatter:on -->
