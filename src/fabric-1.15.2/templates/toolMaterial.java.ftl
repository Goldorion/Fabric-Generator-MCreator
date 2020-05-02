<#-- @formatter:off -->
<#include "mcitems.ftl">

package ${package}.item;

public class ${name}Material implements ToolMaterial{

		@Override
   		public float getAttackDamage() {
			return ${data.damageVsEntity - 1}f;
		}

		@Override
   		public int getDurability() {
			return ${data.usageCount};
		}

		@Override
   		public int getEnchantability() {
			return ${data.enchantability};
		}

		@Override
   		public int getMiningLevel() {
			return ${data.harvestLevel};
		}

		@Override
		public float getMiningSpeed() {
			return ${data.efficiency}f;
		}

		@Override
   		public Ingredient getRepairIngredient() {
			<#if data.repairItems?has_content>
			return Ingredient.ofItems(
					<#list data.repairItems as repairItem>
					${mappedMCItemToItemStackCode(repairItem,1)}<#if repairItem?has_next>,</#if>
                	</#list>
					);
			<#else>
			return Ingredient.EMPTY;
			</#if>
		}

}
<#-- @formatter:on -->