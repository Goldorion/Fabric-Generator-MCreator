<#--
This file is part of Fabric-Generator-MCreator.

Fabric-Generator-MCreator is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Fabric-Generator-MCreator is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with Fabric-Generator-MCreator.  If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->
<#include "procedures.java.ftl">

package ${package}.client.particle;

import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;


@Environment(EnvType.CLIENT)
public class ${name}Particle extends SpriteBillboardParticle {

    private final SpriteProvider spriteProvider;
	<#if data.angularVelocity != 0 || data.angularAcceleration != 0>
		private float angularVelocity;
		private float angularAcceleration;
	</#if>

    protected ${name}Particle(ClientWorld clientWorld, double x, double y, double z, double vx, double vy, double vz, SpriteProvider spriteProvider) {
        super(clientWorld, x, y, z, vx, vy, vz);
        this.spriteProvider = spriteProvider;

		this.setBoundingBoxSpacing((float) ${data.width}, (float) ${data.height});
		this.scale *= (float) ${data.scale};

		<#if (data.maxAgeDiff > 0)>
		this.maxAge = (int) Math.max(1, ${data.maxAge} + (this.random.nextInt(${data.maxAgeDiff * 2}) - ${data.maxAgeDiff}));
		<#else>
		this.maxAge = ${data.maxAge};
		</#if>

		this.gravityStrength = (float) ${data.gravity};
		this.collidesWithWorld = ${data.canCollide};

		this.velocityX = vx * ${data.speedFactor};
		this.velocityY = vy * ${data.speedFactor};
		this.velocityZ = vz * ${data.speedFactor};

		<#if data.angularVelocity != 0 || data.angularAcceleration != 0>
		this.angularVelocity = (float) ${data.angularVelocity};
		this.angularAcceleration = (float) ${data.angularAcceleration};
		</#if>

		<#if data.animate>
		this.setSpriteForAge(spriteProvider);
		<#else>
		this.setSprite(spriteProvider);
		</#if>
    }

	<#if data.renderType == "LIT">
   	    @Override public int getBrightness(float tint) {
			return 15728880;
   		}
	</#if>

    @Override
    public ParticleTextureSheet getType() {
        return ParticleTextureSheet.PARTICLE_SHEET_${data.renderType};
    }

	@Override public void tick() {
		super.tick();

		<#if data.angularVelocity != 0 || data.angularAcceleration != 0>
		    this.prevAngle = this.angle;
		    this.angle += this.angularVelocity;
		    this.angularVelocity += this.angularAcceleration;
		</#if>

		<#if data.animate>
		    if(!this.dead) {
		    	<#assign frameCount = data.getTextureTileCount()>
		    	this.setSprite(this.spriteProvider.getSprite((this.age / ${data.frameDuration}) % ${frameCount} + 1, ${frameCount}));
		    }
		</#if>

		<#if hasCondition(data.additionalExpiryCondition)>
		    double x = this.x;
		    double y = this.y;
		    double z = this.z;
		    if (<@procedureOBJToConditionCode data.additionalExpiryCondition/>)
		    	this.markDead();
		</#if>
	}

	@Environment(EnvType.CLIENT)
	public static class CustomParticleFactory implements ParticleFactory<DefaultParticleType> {
		private final SpriteProvider spriteProvider;

		public CustomParticleFactory(SpriteProvider spriteProvider) {
			this.spriteProvider = spriteProvider;
		}

		public Particle createParticle(DefaultParticleType typeIn, ClientWorld worldIn, double x, double y, double z, double xSpeed, double ySpeed, double zSpeed) {
			return new ${name}Particle(worldIn, x, y, z, xSpeed, ySpeed, zSpeed, this.spriteProvider);
		}
	}
}
<#-- @formatter:on -->