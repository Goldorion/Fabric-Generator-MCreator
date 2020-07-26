(new Object(){boolean check(){
				if(${input$entity} instanceof LivingEntity){
				Collection<StatusEffectInstance> effects=((LivingEntity)${input$entity}).getActivePotionEffects();
					for(StatusEffectInstance effect:effects){
						if(effect.getEffectType()== ${generator.map(field$potion, "potions")}) return true;
					}
				}
		return false;
		}
}.check())