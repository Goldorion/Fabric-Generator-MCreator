<#if !data.flyingMob>
<#include "aiconditions.java.ftl">
this.goalSelector.add(${customBlockIndex+1}, new DoorInteract(this) {
			@Override
			protected void setDoorOpen(boolean open) {
				super.setDoorOpen(true);
			}

			<@conditionCode field$condition/>
		});
</#if>