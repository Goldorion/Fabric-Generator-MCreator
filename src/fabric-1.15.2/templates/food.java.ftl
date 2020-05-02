<#-- @formatter:off -->

package ${package}.item;

public class ${name} extends Item
{
    public ${name}()
    {
        super(new Settings().group(${data.creativeTab}).maxCount(${data.stackSize}).food(new FoodComponent.Builder()
				.hunger(${data.nutritionalValue})
				.saturationModifier(${data.saturation}f)
				<#if data.forDogs>.meat()</#if>
				<#if data.isAlwaysEdible>.alwaysEdible()</#if>
				.build()));
    }
}
<#-- @formatter:on -->