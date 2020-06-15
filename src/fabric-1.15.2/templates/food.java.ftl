<#-- @formatter:off -->

package ${package}.food;

import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;

public class ${name} extends Item{
    public ${name}(){
        super(new Settings().group(${data.creativeTab}).maxCount(${data.stackSize}).food(new FoodComponent.Builder()
				.hunger(${data.nutritionalValue})
				.saturationModifier(${data.saturation}f)
				<#if data.forDogs>.meat()</#if>
				<#if data.isAlwaysEdible>.alwaysEdible()</#if>
				.build()));
    }

    <#if data.hasGlow>
    @Environment(EnvType.CLIENT)
    @Override
    public boolean hasEnchantmentGlint(ItemStack stack){
        return true;
    }
    </#if>

    <#if data.specialInfo?has_content>
		@Override
    public void appendTooltip(ItemStack stack, World world, List<Text> tooltip, TooltipContext context){
		    <#list data.specialInfo as entry>
  	     tooltip.add(new LiteralText("${JavaConventions.escapeStringForJava(entry)}"));
         </#list>
		}
    </#if>

    @Override
		public UseAction getUseAction(ItemStack stack) {
      return UseAction.${data.animation?upper_case};
		}

    <#if data.eatingSpeed != 32>
    @Override
		public int getMaxUseTime(ItemStack stack) {
			return ${data.eatingSpeed};
		}
    </#if>
}
<#-- @formatter:on -->
