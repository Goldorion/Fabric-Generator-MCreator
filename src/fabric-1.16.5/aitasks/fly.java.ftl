<#-- @formatter:off -->
<#include "aiconditions.java.ftl">
this.goalSelector.add(${customBlockIndex+1}, new WanderAroundFarGoal(this, ${field$speed}, 20) {

    @Override
    protected Vec3d getWanderTarget() {
		Random random = ${name}Entity.this.getRandom();
		double dir_x = ${name}Entity.this.getX() + ((random.nextFloat() * 2 - 1) * 16);
		double dir_y = ${name}Entity.this.getY() + ((random.nextFloat() * 2 - 1) * 16);
		double dir_z = ${name}Entity.this.getZ() + ((random.nextFloat() * 2 - 1) * 16);
		return new Vec3d(dir_x, dir_y, dir_z);
	}

	<@conditionCode field$condition false/>

});
<#-- @formatter:on -->