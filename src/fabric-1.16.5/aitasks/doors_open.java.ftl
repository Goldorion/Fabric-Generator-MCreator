<#if !data.flyingMob>
<#include "aiconditions.java.ftl">
this.goalSelector.addGoal(${customBlockIndex+1}, new DoorInteract(this) {
			@Override
			protected void setDoorOpen(boolean open) {
				super.setDoorOpen(true);
			}

			<@conditionCode field$condition/>
		});
</#if>