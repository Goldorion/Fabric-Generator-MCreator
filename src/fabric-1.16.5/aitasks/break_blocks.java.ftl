<#include "mcitems.ftl">
<#include "aiconditions.java.ftl">
this.goalSelector.add(${customBlockIndex+1}, new StepAndDestroyBlockGoal(${mappedBlockToBlock(input$block)},
        this, ${field$speed}, (int) ${field$y_max})<@conditionCode field$condition/>);