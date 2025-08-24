<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2020-2025, Goldorion, opensource contributors
 #
 # Fabric-Generator-MCreator is free software: you can redistribute it and/or modify
 # it under the terms of the GNU Lesser General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.

 # Fabric-Generator-MCreator is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 # GNU Lesser General Public License for more details.
 #
 # You should have received a copy of the GNU Lesser General Public License
 # along with Fabric-Generator-MCreator.  If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->
<#include "mcitems.ftl">
<#include "procedures.java.ftl">

package ${package}.item.extension;

<#compress>
public class ${name}ItemExtension {
	public static void init() {
		DispenserBlock.registerBehavior(${mappedMCItemToItem(data.item)}, new OptionalDispenseItemBehavior() {
			public ItemStack execute(BlockSource blockSource, ItemStack stack) {
				<#assign hasSuccessCondition = hasProcedure(data.dispenseSuccessCondition)>
				ItemStack itemstack = stack.copy();
				Level world = blockSource.level();
				Direction direction = blockSource.state().getValue(DispenserBlock.FACING);
				int x = blockSource.pos().getX();
				int y = blockSource.pos().getY();
				int z = blockSource.pos().getZ();

				<#if hasSuccessCondition>
					this.setSuccess(<@procedureOBJToConditionCode data.dispenseSuccessCondition/>);
				</#if>

				<#if hasProcedure(data.dispenseResultItemstack)>
					boolean success = this.isSuccess();
					<#if hasReturnValueOf(data.dispenseResultItemstack, "itemstack")>
						return <@procedureOBJToItemstackCode data.dispenseResultItemstack, false/>;
					<#else>
						<@procedureOBJToCode data.dispenseResultItemstack/>
						<#if hasSuccessCondition>if(success)</#if>
						itemstack.shrink(1);
						return itemstack;
					</#if>
				<#else>
					<#if hasSuccessCondition>if(this.isSuccess())</#if>
					itemstack.shrink(1);
					return itemstack;
				</#if>
			}
		});
	}
}</#compress>
<#-- @formatter:on -->