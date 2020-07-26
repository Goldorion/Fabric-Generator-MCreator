<#-- @formatter:off -->
<#include "procedures.java.ftl">

package ${package}.item;

import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;

public class ${name}Item {
    public ${name}Item() {
        super(new Item.Settings().group(${data.creativeTab})
                .maxStackSize(${data.stackSize})
                .food((new FoodComponent.Builder()).hunger(${data.nutritionalValue}).saturationModifier(${data.saturation}f)
				<#if data.isAlwaysEdible>.alwaysEdible()</#if>
				<#if data.forDogs>.meat()</#if>
                        .build()
                ));
    }

    <#if data.eatingSpeed != 32>
		@Override
        public int getMaxUseTime(ItemStack stack) {
            return ${data.eatingSpeed};
        }
    </#if>

    <#if data.hasGlow>
		@Override
        @Environment(EnvType.CLIENT)
        public boolean hasGlint(ItemStack itemstack) {
            return true;
        }
    </#if>

    @Override
    public UseAction getUseAction(ItemStack stack) {
        return UseAction.${data.animation?upper_case};
    }

    <#if data.specialInfo?has_content>
    @Override
    @Environment(EnvType.CLIENT)
    public void appendTooltip(ItemStack stack, @Nullable World world, List<Text> tooltip, TooltipContext context) {
        <#list data.specialInfo as entry>
            tooltip.add(new LiteralText("${JavaConventions.escapeStringForJava(entry)}"));
        </#list>
    }
    </#if>

    <#if hasProcedure(data.onRightClickedInAir)>
    @Override
    public TypedActionResult<ItemStack> use(World world, PlayerEntity user, Hand hand) {
        ItemStack itemstack = super.use(world, user, hand).getResult();
        int x = (int) entity.getPosX();
        int y = (int) entity.getPosY();
        int z = (int) entity.getPosZ();
            <@procedureOBJToCode data.onRightClickedInAir/>
        return super.use(world, user, hand);
    }
    </#if>

    <#if hasProcedure(data.onEaten)>
        @Override
        public ItemStack finishUsing(ItemStack itemStack, World world, LivingEntity entity) {
            int x = (int) entity.getPosX();
            int y = (int) entity.getPosY();
            int z = (int) entity.getPosZ();
			<@procedureOBJToCode data.onEaten/>
            return super.onItemUseFinish(itemStack, world, entity);
        }
    </#if>

    <#if hasProcedure(data.onCrafted)>
    @Override
    public void onCraft(ItemStack stack, World world, PlayerEntity player) {
        super.onCraft(stack, world, player);
        int x = (int) player.getPosX();
        int y = (int) player.getPosY();
        int z = (int) player.getPosZ();
			<@procedureOBJToCode data.onCrafted/>
    }
    </#if>
}
<#-- @formatter:on -->