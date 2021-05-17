<#include "procedures.java.ftl">

<#macro particles type particleObj radius amount condition="">
    <#if type=="Spread">
        <@particlesSpread particleObj radius amount condition/>
    <#elseif type=="Top">
        <@particlesTop particleObj radius amount condition/>
    <#elseif type=="Tube">
        <@particlesTube particleObj radius amount condition/>
    <#elseif type=="Plane">
        <@particlesPlane particleObj radius amount condition/>
    </#if>
</#macro>

<#macro particlesPlane particleObj radius amount condition>
if(<@procedureOBJToConditionCode condition/>)
	for(int l=0;l< ${amount}; ++l) {
		double d0 = (x + 0.5) + (random.nextFloat() - 0.5) * ${radius}D * 20;
		double d1 = ((y + 0.7) + (random.nextFloat() - 0.5) * ${radius}D) + 0.5;
		double d2 = (z + 0.5) + (random.nextFloat() - 0.5) * ${radius}D * 20;
		world.addParticle(${particleObj.toString()}, d0, d1, d2, 0, 0, 0);
	}
</#macro>

<#macro particlesSpread particleObj radius amount condition>
if(<@procedureOBJToConditionCode condition/>)
	for (int l = 0; l < ${amount}; ++l) {
	    double d0 = (x + random.nextFloat());
	    double d1 = (y + random.nextFloat());
	    double d2 = (z + random.nextFloat());
	    int i1 = random.nextInt(2) * 2 - 1;
	    double d3 = (random.nextFloat() - 0.5D) * ${radius}D;
	    double d4 = (random.nextFloat() - 0.5D) * ${radius}D;
	    double d5 = (random.nextFloat() - 0.5D) * ${radius}D;
	    world.addParticle(${particleObj.toString()}, d0, d1, d2, d3, d4, d5);
	}
</#macro>

<#macro particlesTop particleObj radius amount condition>
if(<@procedureOBJToConditionCode condition/>)
    for (int l = 0; l < ${amount}; ++l) {
		double d0 = (double)((float)x + 0.5) + (double)(random.nextFloat() - 0.5) * ${radius}D;
		double d1 = ((double)((float)y + 0.7) + (double)(random.nextFloat() - 0.5) * ${radius}D)+0.5;
		double d2 = (double)((float)z + 0.5) + (double)(random.nextFloat() - 0.5) * ${radius}D;
		world.addParticle(${particleObj.toString()}, d0, d1, d2, 0, 0, 0);
    }
</#macro>

<#macro particlesTube particleObj radius amount condition>
if(<@procedureOBJToConditionCode condition/>)
    for (int l = 0; l < ${amount}; ++l){
		double d0=(x+0.5)+(random.nextFloat()-0.5)* ${radius}D;
		double d1=((y+0.7)+(random.nextFloat()-0.5)* ${radius}D*100)+0.5;
		double d2=(z+0.5)+(random.nextFloat()-0.5)* ${radius}D;
		world.addParticle(${particleObj.toString()},d0,d1,d2,0,0,0);
		}
</#macro>