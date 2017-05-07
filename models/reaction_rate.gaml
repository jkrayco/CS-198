model reaction_rate

global{	
	//rates of the 15 reactions
	float K1 <- 28.0;	//hv + cat -> cat + electron + hole				
	float K2 <- 98.0;	//electron + hole -> {} 						
	float K3 <- 0.030;	//cat + H2O -> cat-H2O 							
	float K4 <- 0.16;	//S 2- + H2O -> HS- + OH -						
	float K5 <- 90.00;	//cat + HS - -> cat-HS -							
	float K6 <- 0.30;	//cat + SO3 2- -> cat-SO3 2-						
	float K7 <- 90.0;	//cat-H2O + cat + electron -> cat-H. + cat-OH - 	
	float K8 <- 100.0;	//2cat-H. -> 2cat + H2
	float K9 <- 98.0;	//cat-HS - + hole -> cat-HS. 						
	float K10 <- 51.0;	//cat-HS. + cat-OH - -> cat-S. - + cat + H2O			
	float K11 <- 93.0;	//cat-HS. + cat-S. - -> cat-HS2 - + cat					
	float K12 <- 0.11;	//cat-HS2 - -> cat + HS2 -								
	float K13 <- 70.0;	//HS2 - + SO3 2- -> S2O3 2- + HS -						
	float K14 <- 0.051;	//cat + OH - -> cat-OH - 								
	float K15 <- 8.95;	//cat + S2O3 2- -> cat-S2O3 2-	
}