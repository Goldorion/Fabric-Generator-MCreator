<#-- @formatter:off -->

package ${package}.block;

public class ${name} extends PlantBlock{
  public TestBlock(Settings settings) {
        super(settings);
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
}

<#-- @formatter:on -->
